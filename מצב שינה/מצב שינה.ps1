$idle_timeout = New-TimeSpan -Minutes 10

Add-Type @'
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
namespace PInvoke.Win32 {
    public static class UserInput {
        [DllImport("user32.dll", SetLastError=false)]
        private static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);
        [StructLayout(LayoutKind.Sequential)]
        private struct LASTINPUTINFO {
            public uint cbSize;
            public int dwTime;
        }
        public static DateTime LastInput {
            get {
                DateTime bootTime = DateTime.UtcNow.AddMilliseconds(-Environment.TickCount);
                DateTime lastInput = bootTime.AddMilliseconds(LastInputTicks);
                return lastInput;
            }
        }
        public static TimeSpan IdleTime {
            get {
                return DateTime.UtcNow.Subtract(LastInput);
            }
        }
        public static int LastInputTicks {
            get {
                LASTINPUTINFO lii = new LASTINPUTINFO();
                lii.cbSize = (uint)Marshal.SizeOf(typeof(LASTINPUTINFO));
                GetLastInputInfo(ref lii);
                return lii.dwTime;
            }
        }
    }
}
'@

$locked = 0;

do {
	
	$idle_time = [PInvoke.Win32.UserInput]::IdleTime;

	if (($locked -eq 0) -And ($idle_time -gt $idle_timeout)) {
		# Lock it
		rundll32.exe user32.dll,LockWorkStation

		$locked = 1;
	}

	if ($idle_time -lt $idle_timeout) {
		$locked = 0;
	}

    Start-Sleep -Seconds 10
}
while (1 -eq 1)
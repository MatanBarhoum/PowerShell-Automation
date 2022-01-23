$averagerel = Get-Ciminstance Win32_ReliabilityStabilityMetrics | Measure-Object -Average -Maximum  -Minimum -Property systemStabilityIndex | Select -Expand average

If ($averagerel -lt 8) {
    return 1
  } else {return 0}

## WebRTC Project 

WebRTC is a project I was working on the last few days. 
My company has Internet Explorer 11 as their Default Browser, and they bought application of Real-Time Conference on the web. This Application working on Chrome only and I've been tasked to find solution to the problem: "We don't want to replace Internet Explorer as our Default browser".
After some time, I created a Macro with VBA which add an button to the Outlook client, and when clicking on this button, it copy the link in the outlook message and open it with chrome. Cyber denied it as this is danger (no really, but still).

Finally, I've come up with the Perfect solution - 
I created a URI scheme, that when I call it with a link and click, he re-direct to an powershell script (which copy the link, and open chrome with Diganostic.System Tool.

Example:
WebRTC:https:/google.com
Will be opened on chrome as "https://google.com" instead of replacing Internet Explorer as Default Browser.

Simply add "WebRTC.reg" - Change whatever URI scheme that you want.
Put WebRTCAlpha.ps1 on C:\WebRTC\.X (.x = ps1 file)
That's it. when you send a "WebRTC:XXXX" link, the WebRTC: will be removed.

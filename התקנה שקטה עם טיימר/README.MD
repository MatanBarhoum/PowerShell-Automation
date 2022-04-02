Batch file that call an PS1 script.

The batch file call the PS1 script which opened in a new windows with start "windowtitle" cmd /c file.bat -wait
the timer help the Workstation user \ Administrator to determine how much time left for the program to finish. It is necessary for the users to understand that the program still running in the background since they doesn't really understand what happened when the cmd window opens..
It is using the passive method because we want the users to see the progress, but the same time without any action. It is important since UAC most of the time block the installation with "Low" Administrative premission's users.


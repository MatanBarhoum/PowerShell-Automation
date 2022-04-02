תוכנה עם סט כלים להתקנה של תוכנה ובדיקות כמו גרסת דוט נט, האם ההתקנה בוצעה בהצלחה.
PS-Remote - Uses PSEXEC function in order to Enable PS-Remoting Service on (Win7 Mostly) computers.

Dot Net Version - Uses Get-ChildItem with filter to query HKLM:\ folder where the Dot Net framework is installed. if the Version is less than 4.6.1 (which is thr requirement for this specific program, it is install the program.

Program Installation Checker - Query the remote computer with Test-Connection first to determine wheter the computer alive or not. if the computer is alive and on, it is checking if the installation folder is on. for example, if I was need to determine if Chrome (Version 9.6.1.5897) is installed, I will query neither Prorgram files and then Program files (x86) to check if the name of the folder OR the version of the EXE files match my version, if it do, A Green text append to my richtextbox function in the program.

Install Program - A text box method that ask the user or administrator to put the computer name. It is have the function to take more than 1 computer with splitter. For example, If I have 25 computers, I can use the text box with ", " splitter between each computer, and it will be stored in the variable correctly.
Exm : com1, com2, com3, com4, com5, com6, com7 .....

Using a ForEach loop to do it automaticlly with integretion with CSV file where I store the computers name with a Header (delimitr for powershell to work correctly), then I store the CSV in variable, and call the header. 
<img src=".\Capture.PNG"></img>

$path = Get-ChildItem "C:\Users\Admin\Desktop\v90 Project\maplev90-master\maplev90-master\server\dist\wz\*"
ForEach ($item in $path.Name) 
{
   $NewItem = $item -replace ".wz",""
   Rename-Item -Path "C:\Users\Admin\Desktop\v90 Project\maplev90-master\maplev90-master\server\dist\wz\$item" -NewName $NewItem
   
}
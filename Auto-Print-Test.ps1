$path = "C:\Users\Admin\Desktop\Print-Test"
$path_create = "C:\Users\Admin\Desktop"
if(!(test-path $path))
{
      New-Item -ItemType Directory -Path $path_create -Name "Print-Test"

}
else{Write-Host "Folder Already created"}
$Word = New-Object -ComObject Word.Application
$Word.Visible = $True
$Document = $Word.Documents.Add()
$Selection = $Word.Selection
$Selection.TypeText("בדיקה אחת שתיים שלוש")
$Selection.TypeParagraph()
$Selection.TypeText("התאריך היום: ")
$Selection.TypeText("$(Get-Date)")
$SaveLoc = "$path\test.docx"
$Document.SaveAs([ref]$SaveLoc,[ref]$SaveFormat::wdFormatDocument)
$word.Quit()
Start-Process -Filepath "$path\test.docx" -verb print
Start-Sleep -Seconds 10
Remove-Item "$path\test.docx"
try {[System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$Word) | out-null}
catch {"Something went wrong"}
[gc]::Collect()
[gc]::WaitForPendingFinalizers()
try {[System.Runtime.InteropServices.Marshal]::ReleaseComObject( $word )}
catch {"Something went wrong"}
Remove-Variable Word

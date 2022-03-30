Add-Type -AssemblyName System.Windows.Forms
$Install_Form = New-Object System.Windows.Forms.Form
$Install_Form.Width = 650
$Install_Form.Height = 600
$Install_Form.Text = "Weco Installer"
$Install_Form.StartPosition = "CenterScreen"

$Install_TextBox = New-Object System.Windows.Forms.RichTextBox
$Install_TextBox.Width = 600
$Install_TextBox.Height = 30
$Install_TextBox.Location = New-Object System.Drawing.Point(20,40)
$Install_TextBox.Font = [System.Drawing.Font]::New("Arial", 10, [System.Drawing.FontStyle]::Bold)
$Install_Form.Controls.Add($Install_TextBox)

$Install_TextBox1 = New-Object System.Windows.Forms.RichTextBox
$Install_TextBox1.Width = 600
$Install_TextBox1.Height = 300
$Install_TextBox1.Location = New-Object System.Drawing.Point(20,250)
$Install_TextBox1.Font = [System.Drawing.Font]::New("Arial", 10, [System.Drawing.FontStyle]::Bold)
$Install_TextBox1.ReadOnly = $true
$Install_Form.Controls.Add($Install_TextBox1)

$Add_Button = New-Object System.Windows.Forms.Button
$Add_Button.Size = New-Object System.Drawing.Point(130,30)
$Add_Button.Location = New-Object System.Drawing.Point(490,80)
$Add_Button.Text = "הוסף מחשבים"
$Add_Button.Font = [System.Drawing.Font]::New("Arial", 11, [System.Drawing.FontStyle]::Bold)
$Install_Form.Controls.Add($Add_Button)

#הוספת פעולה בלחיצה על הוסף מחשבים
$Add_Button.Add_Click{
$global:Computers = $Install_TextBox.Text

#שאילתת אם - אז 
if ($Computers -eq $Install_TextBox.Text) {
$Install_Label = New-Object System.Windows.Forms.Label
$Install_Label.Location = New-Object System.Drawing.Point(475,115)
$Install_Label.Text = "מחשבים נוספו בהצלחה"
$Install_Label.Font = [System.Drawing.Font]::new("Arial", 11, [System.Drawing.FontStyle]::Bold)
$Install_Label.ForeColor = "Green"
$Install_Label.AutoSize = $true
$Install_Form.Controls.Add($Install_Label)

#כפתור התקן תוכנה 
$Install_Button = New-Object System.Windows.Forms.Button
$Install_Button.Size = New-Object System.Drawing.Point(130,30)
$Install_Button.Location = New-Object System.Drawing.Point(490,150)
$Install_Button.Text = "התקן תוכנה"
$Install_Button.Font = [System.Drawing.Font]::New("Arial", 11, [System.Drawing.FontStyle]::Bold)
$Install_Form.Controls.Add($Install_Button)

###תגובה ללחיצה על כפתור התקן תוכנה
$Install_Button.Add_Click{
ForEach ($COM in $Computers) {
if ((Test-Connection -ComputerName $COM -Quiet)) {
    Copy-Item -Path "C:\Users\xx\Desktop\Weco" -Destination "\\$COM\c$" -Force -Recurse -Verbose
    Copy-Item -Path "\\$COM\c$\Weco\Word" -Destination "\\$COM\c$\Users\Default\AppData\Roaming\Microsoft" -Force -Recurse -Verbose
    Start-Sleep -Seconds 2
    Invoke-Command -ComputerName $COM -ErrorAction Continue -ScriptBlock { cmd.exe /c "start /w msiexec /i C:\Weco\WeCo.WordToPdfConverter.Setup.msi /qn" }
    Invoke-Command -ComputerName $COM -ErrorAction Continue -ScriptBlock { cmd.exe /c "start /w msiexec /a C:\Weco\WeCo.WordToPdfConverter.Setup.msi /qn" }
    Start-Sleep -Seconds 2
    $Install_TextBox1.AppendText("Installed Weco on $COM`n")
    $FindDestination = Get-ChildItem -Path "\\$COM\c$\users"
ForEach ($i in $FindDestination) {
if ($i -eq "Public") { Write-Host "Skipped Public" } 
elseif ($i -eq "TEMP") { Write-host "Skipped TEMP" }
else {
     Copy-Item -Path "\\$COM\c$\Weco\Word" -Destination "\\$COM\c$\Users\$i\AppData\Roaming\Microsoft" -Force -Recurse -Verbose
}     
} $Install_TextBox1.AppendText("Installed Weco on $COM Users Profile Succssesfully!`n")
 }
else { $Install_TextBox1.AppendText("Weco Installation Went Wrong...!`n") }
 }
}


}
}





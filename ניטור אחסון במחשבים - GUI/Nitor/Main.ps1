Add-Type -AssemblyName System.Windows.Forms

. (Join-Path "C:\Nitor" "Resize.ps1")
. (Join-Path "C:\Nitor" "Action.ps1")
. (Join-Path "C:\Nitor" "PopUp.ps1")

$Nitor_Form = New-Object System.Windows.Forms.Form
$Nitor_Form.Width = 320
$Nitor_Form.Height = 400
$Nitor_Form.StartPosition = "CenterScreen"
$Nitor_Form.Text = "ניטור אחסון במחשבים"
$Nitor_Form.BackColor = "White"
$Nitor_Form.FormBorderStyle = "FixedDialog"

$img = [System.Drawing.Image]::FromFile(".\logo.png")

$Nitor_Logo = New-Object System.Windows.Forms.PictureBox
$Nitor_Logo.Width = $img.Size.Width
$Nitor_Logo.Height = $img.Size.Height
$Nitor_Logo.Image = $img
$Nitor_Logo.Location = New-Object System.Drawing.Point(10,10)

$Nitor_ComboBox = New-Object System.Windows.Forms.ListBox
$Nitor_ComboBox.AutoSize = $true
$Nitor_ComboBox.Location = New-Object System.Drawing.Point(50,150)
$Nitor_ComboBox.Font = [System.Drawing.Font]::new("Arial", 12, [System.Drawing.FontStyle]::Bold)
$Nitor_ComboBox.RightToLeft = "yes"
$Nitor_Sites = @('Jerusalem', 'TelAviv', 'New York')
foreach ($i in $Nitor_Sites) { $Nitor_ComboBox.Items.Add($i) }

$Nitor_Label = New-Object System.Windows.Forms.Label
$Nitor_Label.Text = "בחר אתר/מחוז"
$Nitor_Label.AutoSize = $true
$Nitor_Label.RightToLeft = "yes"
$Nitor_Label.Font = [System.Drawing.Font]::new("Arial", 12, [System.Drawing.FontStyle]::Bold)
$Nitor_Label.Location = New-Object System.Drawing.Point(180, 180)

## במידה ויש צורך לסמן, נא לערוך את קובץ
## Resize.ps1
## בהתאם 
$Nitor_CheckBox = New-Object System.Windows.Forms.CheckBox
$Nitor_CheckBox.AutoSize = $true
$Nitor_CheckBox.RightToLeft = "yes"
$Nitor_CheckBox.Font = [System.Drawing.Font]::new("Arial", 9, [System.Drawing.FontStyle]::Bold)
$Nitor_CheckBox.Location = New-Object System.Drawing.Point(1, 250)
$Nitor_CheckBox.Text = "סמן במידה והאתר מכיל הרבה מחשבים ואפשר לצמצם"
$Nitor_CheckBox.CheckState = "Unchecked"

$Nitor_Ok = New-Object System.Windows.Forms.Button
$Nitor_Ok.Text = "המשך"
$Nitor_Ok.DialogResult = [System.Windows.Forms.DialogResult]::OK
$Nitor_Ok.AutoSize = $true
$Nitor_Ok.Location = [System.Drawing.Point]::new(170,320)

$Nitor_Abort = New-Object System.Windows.Forms.Button
$Nitor_Abort.Text = "ביטול"
$Nitor_Abort.DialogResult = [System.Windows.Forms.DialogResult]::Abort
$Nitor_Abort.AutoSize = $true
$Nitor_Abort.Location = [System.Drawing.Point]::new(80,320)

$Nitor_Form.Controls.Add($Nitor_Ok)
$Nitor_Form.Controls.Add($Nitor_Abort)
$Nitor_Form.Controls.Add($Nitor_CheckBox);
$Nitor_Form.Controls.Add($Nitor_Label);
$Nitor_Form.Controls.Add($Nitor_ComboBox)
$Nitor_Form.Controls.Add($Nitor_Logo)
$Result = $Nitor_Form.ShowDialog()

if ($Result -eq [System.Windows.Forms.DialogResult]::OK) {
if ($Nitor_CheckBox.Checked -eq $true)
{
    PopUpResize
    Action
}
else 
{
    PopUp
    Action
}

 }
Add-Type -AssemblyName System.Windows.Forms

function resize {
$Resize_Form = New-Object System.Windows.Forms.Form
$Resize_Form.Width = 320
$Resize_Form.Height = 200
$Resize_Form.StartPosition = "CenterScreen"
$Resize_Form.Text = "צמצום בחירה"
$Resize_Form.BackColor = "White"
$Resize_Form.FormBorderStyle = "FixedDialog"

$Resize_ListBox = [System.Windows.Forms.ListBox]::new()
$Resize_ListBox.Width = 120
$Resize_ListBox.Font = [System.Drawing.Font]::new("Arial", 11, [System.Drawing.FontStyle]::Bold)
$Resize_ListBox.RightToLeft = "yes"
$Resize_ListBox.Location = [System.Drawing.Point]::new(10,10)

$Resize_Label = [System.Windows.Forms.Label]::new()
$Resize_Label.Font = [System.Drawing.Font]::new("Arial", 12, [System.Drawing.FontStyle]::Bold)
$Resize_Label.Text = "בחר אתר/מחוז מצומצם"
$Resize_Label.AutoSize = $true
$Resize_Label.Location = [System.Drawing.Point]::new(150,50)

$Resize_Ok = New-Object System.Windows.Forms.Button
$Resize_Ok.Text = "המשך"
$Resize_Ok.DialogResult = [System.Windows.Forms.DialogResult]::OK
$Resize_Ok.AutoSize = $true
$Resize_Ok.Location = [System.Drawing.Point]::new(125,130)

Switch -Wildcard ($Nitor_ComboBox.SelectedItem) 
{
#case
"ירושלים" {$Resize_Site = @('TalpiyotOU', 'RamotOU', 'DerecHevronOU')}
#case
"תל אביב" {$Resize_Site = @('DerecHasalom', 'Bograshov', 'Ehad_Aam')}
#case
"ניו-יורק" {$Resize_Site = @('BroadWayOU', 'AvenueOU', 'FifthAvenueOU')}
default {[System.Windows.MessageBox]::Show("לא נבחר אתר, אנא שים לב")}
}
foreach ($i in $Resize_Site) {$Resize_ListBox.Items.Add($i)}


$Resize_Form.Controls.Add($Resize_Ok)
$Resize_Form.Controls.Add($Resize_Label)
$Resize_Form.Controls.Add($Resize_ListBox)
$Resize_Form.ShowDialog()
$Resize_ListBox.SelectedItem
}

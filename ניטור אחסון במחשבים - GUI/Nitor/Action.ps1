Add-Type -AssemblyName System.Windows.Forms
. (Join-Path "C:\Nitor" "Resize.ps1")
. (Join-Path "C:\Nitor" "PopUp.ps1")

function Action {
$Action_Form = [System.Windows.Forms.Form]::new()
$Action_Form.Text = "תוצאות"
$Action_Form.Height = 400
$Action_Form.Width = 400
$Action_Form.BackColor = "White"
$Action_Form.StartPosition = "CenterScreen"

$Action_RTextBox = [System.Windows.Forms.RichTextBox]::new()
$Action_RTextBox.ReadOnly = $true
$Action_RTextBox.BorderStyle = "Fixed3D"
$Action_RTextBox.Location = [System.Drawing.Point]::new(1,1)
$Action_RTextBox.Size = [System.Drawing.Point]::new(380,350)
$Action_RTextBox.Font = [System.Drawing.Font]::new("Arial", 11, [System.Drawing.FontStyle]::Bold)
$ChooseNitor = $Nitor_ComboBox.SelectedItem
$TEST123 = Get-ADComputer -Filter * -SearchBase "OU=Computers,OU=$ChooseNitor,DC=gov,DC=il" | Select -ExpandProperty Name
ForEach ($Computer in $OU_AliveComputers) {
$Action_RTextBox.AppendText("$Computer Have less than 20GB free space`n")
}

$Action_Form.Controls.Add($Action_RTextBox)
$Action_Form.ShowDialog();

}

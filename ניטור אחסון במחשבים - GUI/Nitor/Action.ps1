Add-Type -AssemblyName System.Windows.Forms
. (Join-Path "C:\Nitor" "Resize.ps1")

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

$Action_OU1 = $Resize_ListBox.SelectedItem
$Action_OU2 = $Nitor_ComboBox.SelectedItem
$Ou_Outpot = Get-ADComputer -Filter * -SearchBase "OU=Computers,OU=$Action_OU1,OU=$Action_OU2,DC=domain,DC=com"
ForEach ($i in $Ou_Outpot) 

$Action_Form.Controls.Add($Action_RTextBox)

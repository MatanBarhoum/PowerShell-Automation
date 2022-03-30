Add-Type -AssemblyName System.Windows.Forms
$PS_Form = New-Object System.Windows.Forms.Form
$PS_Form.Width = 500
$PS_Form.Height = 400
$PS_Form.Text = "PS-Remoting Force Program"
$PS_Form.StartPosition = "CenterScreen"

$PS_Form_Label = New-Object System.Windows.Forms.Label
$PS_Form_Label.Location = New-Object System.Drawing.Point(20,22)
$PS_Form_Label.Text = "Computer Name:"
$PS_Form.Controls.Add($PS_Form_Label)

$PS_Form_TextBox = New-Object System.Windows.Forms.TextBox
$PS_Form_TextBox.Size = New-Object System.Drawing.Point(350,3)
$PS_Form_TextBox.Location = New-Object System.Drawing.Point(120,20)
$PS_Form.Controls.Add($PS_Form_TextBox)

$PS_Form_Button = New-Object System.Windows.Forms.Button
$PS_Form_Button.Size = New-Object System.Drawing.Point(130,50)
$PS_Form_Button.Location = New-Object System.Drawing.Point(20,50)
$PS_Form_Button.Text = "PS-Remote Force"
$PS_Form.Controls.Add($PS_Form_Button)

$PS_Form_RichTextBox = New-Object System.Windows.Forms.RichTextBox
$PS_Form_RichTextBox.ReadOnly = $true
$PS_Form_RichTextBox.Location = New-Object System.Drawing.Point(1,130)
$PS_Form_RichTextBox.Size = New-Object System.Drawing.Point(470,220)
$PS_Form_RichTextBox.Font = [System.Drawing.Font]::New("Arial", 11, [System.Drawing.FontStyle]::Bold)
$PS_Form.Controls.Add($PS_Form_RichTextBox)

$PS_Form_Button.Add_Click{
$Computers = $PS_Form_TextBox.Text

Foreach ($i in $Computers) {
if (Test-Connection -ComputerName $i -Quiet) {
    ''
    $PS_Form_RichTextBox.AppendText("Successfully pinged $i`n")
    Try {cmd.exe /c psexec \\$i -s -d powershell Enable-PSRemoting -Force}
    Catch { $PS_Form_RichTextBox.AppendText( "Error`n" )}
    Finally { $PS_Form_RichTextBox.AppendText( "Connected to $i With Psexec`n" )
    $PS_Form_RichTextBox.SelectionColor = "green"
    $PS_Form_RichTextBox.AppendText( "PS Remoting Enabled on $i`n" )}

 }
 else { $PS_Form_RichTextBox.AppendText( "Computer $i is not connected`n" )} 
 }
 
}

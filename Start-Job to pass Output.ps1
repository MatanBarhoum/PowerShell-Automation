$global:ComputerList = @();

$form = New-Object System.Windows.Forms.Form;
$form.Width = 500;
$form.Height = 400;
$form.StartPosition = "CenterScreen";

$RichTextBox = New-Object System.Windows.Forms.RichTextBox;
$RichTextBox.ReadOnly = $true;
$RichTextBox.Location = New-Object System.Drawing.Point(1,1);
$RichTextBox.Width = 480;
$RichTextBox.Height = 320;

$button = New-Object System.Windows.Forms.Button;
$button.Text = "התחל";
$button.AutoSize = $true
$button.Location = New-Object System.Drawing.Point(210,325)

$form.Controls.Add($RichTextBox);
$form.Controls.Add($button);

function ComputerList
{
Start-Job -Name "ComputerList89001" -ScriptBlock { $i = 1..20 
foreach ($k in $i) { Write-Output "192.168.0.$k" } }
}

$button.Add_Click({
ComputerList

$global:ReceiveList = Receive-Job -Name "ComputerList89001";
ForEach ($j in $global:ReceiveList) 
{
    $RichTextBox.AppendText("$j`n")
}
})

$form.showdialog()

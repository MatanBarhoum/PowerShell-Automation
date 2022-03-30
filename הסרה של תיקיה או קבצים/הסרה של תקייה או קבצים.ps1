$Computers = Import-CSV -Path "C:\Users\xxxxx\Desktop\WecoProject.csv" | Select -ExpandProperty ComputerName
Add-Type -AssemblyName System.Windows.Forms
$Main_Form = New-Object System.Windows.Forms.Form
$Main_Form.Width = 700
$Main_Form.Height = 700
$Main_Form.Text = "הסרה של תיקיה"

$RichTextBox = New-Object System.Windows.Forms.RichTextBox
$RichTextBox.ReadOnly = $True
$RichTextBox.Location = New-Object System.Drawing.Point(1,1)
$RichTextBox.Size = New-Object System.Drawing.Point(500,650)
$RichTextBox.Font = [System.Drawing.Font]::new("Arial", 12, [System.Drawing.FontStyle]::Bold)
$Main_Form.Controls.Add($RichTextBox)

$Button1 = New-Object System.Windows.Forms.Button
$Button1.Size = New-Object System.Drawing.Point(150,50)
$Button1.Location = New-Object System.Drawing.Point(520, 300)
$Button1.Text = "הסרה"
$Button1.Font = [System.Drawing.Font]::New("Arial", 12, [System.Drawing.FontStyle]::Bold)
$Main_Form.Controls.Add($Button1)

$Button1.Add_Click{
foreach ( $i in $Computers ) 
{
    if (((Test-Path "\\$i\c$\Weco") -eq $true) -and (Test-Connection -ComputerName $i -Count 1 -Quiet) -eq $true)
        {   $RichTextBox.SelectionColor = "green"
            Remove-Item -Path "\\$i\c$\Weco" -Recurse -Verbose
            $RichTextBox.AppendText("Weco folder removed Successfully`n") } 

    elseif (((Test-Path "\\$i\c$\Weco") -eq $false) -and (Test-Connection -ComputerName $i -Count 1 -Quiet) -eq $true) {
            $RichTextBox.SelectionColor = "Orange"
            $RichTextBox.AppendText("No such folder exist`n") }

    else { $RichTextBox.SelectionColor = "red"
           $RichTextBox.AppendText("Weco Folder didn't removed Succesfully`n")  }
}
}

$Main_Form.ShowDialog()



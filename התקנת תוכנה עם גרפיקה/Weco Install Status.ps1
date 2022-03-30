##יבוא CSV
$CSV = Import-CSV -Path "C:\Users\e209216019\Desktop\WecoProject.csv" 
$StatusRed = ""
$Computers = $CSV.ComputerName

#Form
Add-Type -AssemblyName System.Windows.Forms
$Status_Form = New-Object System.Windows.Forms.Form
$Status_Form.Width = 600
$Status_Form.Height = 600
$Status_Form.Text = "We-Co Installer Status Bar"


##Form_Button
$CheckStatus = New-Object System.Windows.Forms.Button
$CheckStatus.Text = "בדיקה"
$CheckStatus.Location = New-Object System.Drawing.Point(430,80)
$CheckStatus.Size = New-Object System.Drawing.Size(100,50)
$CheckStatus.Font = [System.Drawing.Font]::New("Arial", 11.5, [System.Drawing.FontStyle]::Bold)
$Status_Form.Controls.Add($CheckStatus)

##Text Box
$CheckBox = New-Object System.Windows.Forms.RichTextBox
$CheckBox.ReadOnly = $true
$CheckBox.Size = New-Object System.Drawing.Point(380,550)
$CheckBox.Font = [System.Drawing.Font]::New("Arial", 9, [System.Drawing.FontStyle]::Bold)
$Status_Form.Controls.Add($CheckBox)


$CheckStatus.Add_click{
$Text = ""
ForEach ($Computer in $Computers) { 
$Computer = "$Computer"
$Computer

        if (((Test-Path "\\$Computer\c$\Program Files (x86)\WeCo\WeCo.WordToPdfConverter.Setup") -or (Test-Path "\\$Computer\c$\Program Files\WeCo\WeCo.WordToPdfConverter.Setup") -eq "True") -and (Test-Connection -ComputerName $Computer -Count 1 -Quiet) ) {
        $CheckBox.SelectionColor = [Drawing.Color]::Green
        $CheckBox.AppendText("$Computer Checked Succsessfully`n") } 
        else { $StatusRed += "$Computer,"
        $StatusRed = $StatusRed -replace "$Computer,", -join ("'$Computer'", ",")
        
        $CheckBox.SelectionColor = [Drawing.Color]::Red 
        $CheckBox.AppendText("$Computer Checked Not Succsessfully`n")
              } 
              
       } 
       
       }


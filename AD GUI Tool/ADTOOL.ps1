Import-Module ActiveDirectory
Add-Type -AssemblyName System.Windows.Forms
## Create the main form 
$Main_Form = [System.Windows.Forms.Form]::new();
$Main_Form.Width = 700
$Main_Form.Height = 150
$Main_Form.FormBorderStyle = "FixedDialog"
$Main_Form.MinimizeBox = $false
$Main_Form.MaximizeBox = $false
$Main_Form.StartPosition = 'CenterScreen'
$Main_Form.Text = "Created by Matan Barhoum"
$Main_Form.BackColor = "White"


## Buttons
$Button_Users = [System.Windows.Forms.Button]::new()
$Button_Users.AutoSize = $true
$Button_Users.Font = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$Button_Users.Text = "יוזרים מעל 100 יום"
$Button_Users.Location = [System.Drawing.Point]::new(450,30)
$Button_Users.FlatStyle = "Flat"
$Button_Users.Add_Click({Last100DaysUsers})

$Button_Computers = [System.Windows.Forms.Button]::new()
$Button_Computers.AutoSize = $true
$Button_Computers.Font = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$Button_Computers.Text = "מחשבים מעל 100 יום"
$Button_Computers.Location = [System.Drawing.Point]::new(230,30)
$Button_Computers.FlatStyle = "Flat"
$Button_Computers.Add_Click({Last100DaysComputers})

$Button_Duplicates = [System.Windows.Forms.Button]::new()
$Button_Duplicates.AutoSize = $true
$Button_Duplicates.Font = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$Button_Duplicates.Text = "מחשבים כפולים"
$Button_Duplicates.Location = [System.Drawing.Point]::new(57,30)
$Button_Duplicates.FlatStyle = "Flat"
$Button_Duplicates.Add_Click({DuplicateComputers})
## End of button

## Label for "created by or barhoum"
$Credit_Label = [System.Windows.Forms.Label]::new()
$Credit_Label.Text = "Created by Matan Barhoum"
$Credit_Label.Font = [System.Drawing.Font]::new("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$Credit_Label.Location = [System.Drawing.Point]::new(250,80)
$Credit_Label.AutoSize = $true

## Add buttons to the form
$Main_Form.Controls.Add($Button_Users);
$Main_Form.Controls.Add($Button_Computers);
$Main_Form.Controls.Add($Button_Duplicates);
$Main_Form.Controls.Add($Credit_Label);
##פונקציות שיצרתי כדי להפעיל פעולות מסויימות רק שיקראו להם, למשל כשאתה לוחץ על כפתור הוא קורא לפונקציה מסויימת
Function DuplicateComputers
{
    Import-Module ActiveDirectory
Add-Type -AssemblyName System.Windows.Forms
## Last 100 Days Users Form
$Duplicate_Form = [System.Windows.Forms.Form]::new();
$Duplicate_Form.Width = 600
$Duplicate_Form.Height = 500
$Duplicate_Form.StartPosition = 'CenterScreen'
$Duplicate_Form.FormBorderStyle = "FixedDialog"
$Duplicate_Form.MinimizeBox = $false
$Duplicate_Form.MaximizeBox = $false
$Duplicate_Form.Text = "כפילויות מחשבים - נוצר על ידי מתן ברהום"
$Duplicate_Form.BackColor = "White"
$Duplicate_Form.RightToLeft = "yes"

##RichTextBox for user fill
$RichTextBox_Duplicates = [System.Windows.Forms.RichTextBox]::new()
$RichTextBox_Duplicates.ReadOnly = $True
$RichTextBox_Duplicates.Location = [System.Drawing.Point]::new(1,1)
$RichTextBox_Duplicates.Width = 585
$RichTextBox_Duplicates.Height = 400
$RichTextBox_Duplicates.Font = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)

##Start Button
$Start_Button_Duplicates = [System.Windows.Forms.Button]::new()
$Start_Button_Duplicates.AutoSize = $true
$Start_Button_Duplicates.Font = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$Start_Button_Duplicates.Text = "התחל"
$Start_Button_Duplicates.Location = [System.Drawing.Point]::new(250,410)
$Start_Button_Duplicates.Add_Click({
$List = @{}

$Computers = Get-ADComputer -Filter *

ForEach ($Computer In $Computers)
{
    $Name = $Computer.Name
    If ($List.ContainsKey($Name))
    {
        $RichTextBox_Duplicates.AppendText($Computer.Name)
    }
    Else
    {
        $List.Add($Name, $Computer.distinguishedName)
    }
}

})

$Duplicate_Form.Controls.Add($RichTextBox_Duplicates)
$Duplicate_Form.Controls.Add($Start_Button_Duplicates)
$Duplicate_Form.ShowDialog();
}

Function Last100DaysUsers 
{
    Import-Module ActiveDirectory
Add-Type -AssemblyName System.Windows.Forms
## Last 100 Days Users Form
$Last100Users_Form = [System.Windows.Forms.Form]::new();
$Last100Users_Form.Width = 600
$Last100Users_Form.Height = 500
$Last100Users_Form.FormBorderStyle = "FixedDialog"
$Last100Users_Form.MinimizeBox = $false
$Last100Users_Form.MaximizeBox = $false
$Last100Users_Form.StartPosition = 'CenterScreen'
$Last100Users_Form.Text = "יוזרים לא פעילים מעל 100 יום - מתן ברהום"
$Last100Users_Form.BackColor = "White"
$Last100Users_Form.RightToLeft = "yes"

##RichTextBox for user fill
$RichTextBox_Users = [System.Windows.Forms.RichTextBox]::new()
$RichTextBox_Users.ReadOnly = $True
$RichTextBox_Users.Location = [System.Drawing.Point]::new(1,1)
$RichTextBox_Users.Width = 585
$RichTextBox_Users.Height = 400
$RichTextBox_Users.Font = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)

##Start Button
$Start_Button = [System.Windows.Forms.Button]::new()
$Start_Button.AutoSize = $true
$Start_Button.Font = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$Start_Button.Text = "התחל"
$Start_Button.Location = [System.Drawing.Point]::new(250,410)
$Start_Button.Add_Click({
$date1= (Get-Date).AddDays(-1)
$Result = Get-ADUser -Properties LastLogonDate -Filter {LastLogonDate -lt $date1} | Select -ExpandProperty SamAccountName
foreach ($i in $Result) {
$ResultDate = Get-ADUser -Identity "$i" -Properties LastLogonDate | Select -ExpandProperty LastLogonDate
$RichTextBox_Users.AppendText("$i התחבר לאחרונה ב: $ResultDate`n")
}
})

$Last100Users_Form.Controls.Add($RichTextBox_Users)
$Last100Users_Form.Controls.Add($Start_Button)
$Last100Users_Form.ShowDialog();
}

Function Last100DaysComputers 
{
    Import-Module ActiveDirectory
Add-Type -AssemblyName System.Windows.Forms
## Last 100 Days Users Form
$Last100Computers_Form = [System.Windows.Forms.Form]::new();
$Last100Computers_Form.Width = 600
$Last100Computers_Form.Height = 500
$Last100Computers_Form.StartPosition = 'CenterScreen'
$Last100Computers_Form.FormBorderStyle = "FixedDialog"
$Last100Computers_Form.MinimizeBox = $false
$Last100Computers_Form.MaximizeBox = $false
$Last100Computers_Form.Text = "מחשבים לא פעילים מעל 100 יום - מתן ברהום"
$Last100Computers_Form.BackColor = "White"
$Last100Computers_Form.RightToLeft = "yes"

##RichTextBox for user fill
$RichTextBox_Computers = [System.Windows.Forms.RichTextBox]::new()
$RichTextBox_Computers.ReadOnly = $True
$RichTextBox_Computers.Location = [System.Drawing.Point]::new(1,1)
$RichTextBox_Computers.Width = 585
$RichTextBox_Computers.Height = 400
$RichTextBox_Computers.Font = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)

##Start Button
$Start_Button_Computers = [System.Windows.Forms.Button]::new()
$Start_Button_Computers.AutoSize = $true
$Start_Button_Computers.Font = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$Start_Button_Computers.Text = "התחל"
$Start_Button_Computers.Location = [System.Drawing.Point]::new(250,410)
$Start_Button_Computers.Add_Click({
$date1= (Get-Date).AddDays(-1)
$Result = Get-ADComputer -Properties LastLogonDate -Filter {LastLogonDate -lt $date1} | Select -ExpandProperty Name
foreach ($i in $Result) {
$ResultDate = Get-ADComputer -Identity "$i" -Properties LastLogonDate | Select -ExpandProperty LastLogonDate
$RichTextBox_Computers.AppendText("$i התחבר לאחרונה ב: $ResultDate`n")
}
})

$Last100Computers_Form.Controls.Add($RichTextBox_Computers)
$Last100Computers_Form.Controls.Add($Start_Button_Computers)
$Last100Computers_Form.ShowDialog();
}
$Main_Form.ShowDialog();


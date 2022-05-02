## Add Forms Class
Add-Type -AssemblyName System.Windows.Forms

#OOP
. (Join-Path $PSScriptRoot "ActionOnClick.ps1")

## Form Main Interface
$AlertForm = [System.Windows.Forms.Form]::new()
$AlertForm.RightToLeft = "yes"
$AlertForm.FormBorderStyle = "FixedDialog"
$AlertForm.Text = "מערכת שליחת מיילים"
$AlertForm.Width = 500
$AlertForm.Height = 300
$AlertForm.BackColor = "White"
$AlertForm.MaximizeBox = $false
$AlertForm.StartPosition = "CenterScreen"

## Label For "To:"
$AlertLabel1 = [System.Windows.Forms.Label]::new()
$AlertLabel1.Text = "אל:"
$AlertLabel1.AutoSize = $true
$AlertLabel1.Font = [System.Drawing.Font]::new("Arial", 11, [System.Drawing.FontStyle]::Bold)
$AlertLabel1.Location = [System.Drawing.Point]::new(450,20)

##TextBox for "To:"
$AlertTextBox = [System.Windows.Forms.TextBox]::new()
$AlertTextBox.Width = 300
$AlertTextBox.Location = [System.Drawing.Point]::new(140,20)
$AlertTextBox.BorderStyle = "FixedSingle"

##Label for "Message"
$AlertLabel2 = [System.Windows.Forms.Label]::new()
$AlertLabel2.Text = "גוף ההודעה"
$AlertLabel2.AutoSize = $true
$AlertLabel2.Font = [System.Drawing.Font]::new("Arial", 11, [System.Drawing.FontStyle]::Bold)
$AlertLabel2.Location = [System.Drawing.Point]::new(400, 70)

##Label for "הפרד באמצעות"
$AlertLabel3 = [System.Windows.Forms.Label]::new()
$AlertLabel3.Text = "*הפרד אנשי קשר באמצעות ;"
$AlertLabel3.ForeColor = "DarkRed"
$AlertLabel3.AutoSize = $true
$AlertLabel3.Font = [System.Drawing.Font]::new("Arial", 10, [System.Drawing.FontStyle]::Bold)
$AlertLabel3.Location = [System.Drawing.Point]::new(320, 45)

##RichTextBox for "Message"
$AlertRichTextBox = [System.Windows.Forms.RichTextBox]::new()
$AlertRichTextBox.Width = 350
$AlertRichTextBox.Height = 150
$AlertRichTextBox.Location = [System.Drawing.Point]::new(130, 100)
$AlertRichTextBox.BorderStyle = "FixedSingle"

##Send Button
$AlertSend = [System.Windows.Forms.Button]::new()
$AlertSend.AutoSize = $true
$AlertSend.Text = "שלח הודעה"
$AlertSend.Font = [System.Drawing.Font]::new("Arial", 11, [System.Drawing.FontStyle]::Bold)
$AlertSend.Location = [System.Drawing.Point]::new(15, 150)

#Controls
$AlertForm.Controls.Add($AlertLabel1)
$AlertForm.Controls.Add($AlertTextBox)
$AlertForm.Controls.Add($AlertLabel2)
$AlertForm.Controls.Add($AlertRichTextBox)
$AlertForm.Controls.Add($AlertSend)
$AlertForm.Controls.Add($AlertLabel3)

##Send Button Action
$AlertSend.add_click{
    ActionOnClick
}

#Main Form ShowDialog Function
$AlertForm.ShowDialog()


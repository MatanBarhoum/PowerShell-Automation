function ActionClicker{

## Result store the string of the data grid, and then we can call the indexes of this variable. [0] for process name, [1] for process id, [2] for window title.
$Result = $dgw_Form.SelectedRows.Cells | Select -ExpandProperty Value
## on google chrome there is a problem that the window title is "Some title" - google chrome, which cause the program to misunderstand the window title, so regex is used to replace the " - google chrome" with empty and then the program understand the window title.
## should be noted in another programs, accordingly.
$Result[2] -replace "\( - Google Chrome.*\)",""

## main form for the GUI
$ActionForm = [System.Windows.Forms.Form]::new()
$ActionForm.Width = 400
$ActionForm.Height = 200
$ActionForm.Text = "פעולה"
$ActionForm.MaximizeBox = $false
$ActionForm.FormBorderStyle = "FixedDialog"
$ActionForm.BackColor = "White"
$ActionForm.StartPosition = "CenterScreen"


$ActionTextBoxDemo = [System.Windows.Forms.TextBox]::new()
$ActionTextBoxDemo.AutoSize = $true
$ActionTextBoxDemo.Text = ""
$ActionTextBoxDemo.Width = 1
$ActionTextBoxDemo.Location = [System.Drawing.Point]::new(1,1)

## process name text box, read only to show process name.
$ActionTextBox = [System.Windows.Forms.TextBox]::new()
$ActionTextBox.ReadOnly = $true
$ActionTextBox.Width = 130
$ActionTextBox.Location = [System.Drawing.Point]::new(110, 10);
$ActionTextBox.Text = $Result[0]

## process id text box, read only to show process id
$ActionTextBox1 = [System.Windows.Forms.TextBox]::new()
$ActionTextBox1.ReadOnly = $true
$ActionTextBox1.Width = 130
$ActionTextBox1.Location = [System.Drawing.Point]::new(90, 50);
$ActionTextBox1.Text = $Result[1]

## window title text box, read only to show and validate the window title.
$ActionTextBox2 = [System.Windows.Forms.TextBox]::new()
$ActionTextBox2.ReadOnly = $true
$ActionTextBox2.Width = 250
$ActionTextBox2.Location = [System.Drawing.Point]::new(100, 90);
$ActionTextBox2.Text = $Result[2]

#Labels
$ActionLabel = [System.Windows.Forms.Label]::new()
$ActionLabel.AutoSize = $true
$ActionLabel.Text = "Process Name"
$ActionLabel.Location = [System.Drawing.Point]::new(8, 12)
$ActionLabel.Font = [System.Drawing.Font]::new("Arial", 9, [System.Drawing.FontStyle]::Bold)

$ActionLabel1 = [System.Windows.Forms.Label]::new()
$ActionLabel1.AutoSize = $true
$ActionLabel1.Text = "Process ID"
$ActionLabel1.Location = [System.Drawing.Point]::new(8, 54)
$ActionLabel1.Font = [System.Drawing.Font]::new("Arial", 9, [System.Drawing.FontStyle]::Bold)

$ActionLabel2 = [System.Windows.Forms.Label]::new()
$ActionLabel2.AutoSize = $true
$ActionLabel2.Text = "Windows Title"
$ActionLabel2.Location = [System.Drawing.Point]::new(8, 94)
$ActionLabel2.Font = [System.Drawing.Font]::new("Arial", 9, [System.Drawing.FontStyle]::Bold)

$ActionLabelStatus = [System.Windows.Forms.Label]::new()
$ActionLabelStatus.AutoSize = $true
$ActionLabelStatus.Location = [System.Drawing.Point]::new(165, 150)
$ActionLabelStatus.Font = [System.Drawing.Font]::new("Arial", 9, [System.Drawing.FontStyle]::Bold)
$ActionLabelStatus.Text = "סטטוס: ממתין"
$ActionLabelStatus.RightToLeft = "yes"
## End of labels 

##start of buttons
##start button
$ActionStartButton = [System.Windows.Forms.Button]::new()
$ActionStartButton.Text = "הפעל"
$ActionStartButton.AutoSize = $true
$ActionStartButton.Location = [System.Drawing.Point]::new(260, 120)

##abort button
$ActionAbortButton = [System.Windows.Forms.Button]::new()
$ActionAbortButton.Text = "הפסק"
$ActionAbortButton.AutoSize = $true
$ActionAbortButton.Location = [System.Drawing.Point]::new(170, 120)

##exit button
$ActionExitButton = [System.Windows.Forms.Button]::new()
$ActionExitButton.Text = "יציאה"
$ActionExitButton.AutoSize = $true
$ActionExitButton.Location = [System.Drawing.Point]::new(80, 120)
$ActionExitButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel

## main form add controls
$ActionForm.Controls.Add($ActionTextBoxDemo)
$ActionForm.Controls.Add($ActionLabel)
$ActionForm.Controls.Add($ActionLabel1)
$ActionForm.Controls.Add($ActionLabel2)
$ActionForm.Controls.Add($ActionTextBox)
$ActionForm.Controls.Add($ActionTextBox1)
$ActionForm.Controls.Add($ActionTextBox2)
$ActionForm.Controls.Add($ActionStartButton)
$ActionForm.Controls.Add($ActionAbortButton)
$ActionForm.Controls.Add($ActionExitButton)
$ActionForm.Controls.Add($ActionLabelStatus)

$ActionStartButton.Add_click{
    $ActionLabelStatus.ForeColor = "green"
    $ActionLabelStatus.Text = "סטטוס: פועל"
    Enable
    }

$ActionAbortButton.Add_click{
    $ActionLabelStatus.ForeColor = "Red"
    $ActionLabelStatus.Text = "סטטוס: הופסק"
    Disable
    }
$ActionForm.ShowDialog();
}

## enable function, used on "ActionClicker" Start button.

function Enable {
[void] [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic")
[Microsoft.VisualBasic.Interaction]::AppActivate($Result[2])
Start-Job -Name "Enable" -ScriptBlock {
$MOVEMENTSIZE = 10

$global:istrue = $true
While($istrue) {
$POSITION = [Windows.Forms.Cursor]::Position
$POSITION.x += $MOVEMENTSIZE
$POSITION.y += $MOVEMENTSIZE
[Windows.Forms.Cursor]::Position = $POSITION
[void] [System.Reflection.Assembly]::LoadWithPartialName("'System.Windows.Forms")
[System.Windows.Forms.SendKeys]::SendWait("{F5}")
[System.Threading.Thread]::Sleep(5000)
$POSITION = [Windows.Forms.Cursor]::Position
$POSITION.x -= $MOVEMENTSIZE
$POSITION.y -= $MOVEMENTSIZE
[Windows.Forms.Cursor]::Position = $POSITION
[System.Threading.Thread]::Sleep(5000)
}
} ## end of the while loop 
}

## disable function to set the bool to false and end the while "true" loop.
## the function that is used on "action clicker" cancel button.
function Disable {
    $Global:istrue = $false
    Stop-Job -Name "Enable"
    Remove-Job -Name "Enable"
}


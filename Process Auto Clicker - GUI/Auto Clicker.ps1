## OOP calling to another "class"
. (Join-Path $PSScriptRoot "ActionClicker.ps1" )

## Main Form
$Main_Form = [System.Windows.Forms.Form]::new();
$Main_Form.Width = 500;
$Main_Form.Height = 250;
$Main_Form.Text = "Auto Clicker";
$Main_Form.BackColor = "White";
$Main_Form.MaximizeBox = $false
$Main_Form.FormBorderStyle = "FixedDialog"
$Main_Form.CancelButton = $Pick_Button
$Main_Form.StartPosition = "CenterScreen"

#Pick Button
$Pick_Button = [System.Windows.Forms.Button]::new()
$Pick_Button.Text = "בחר"
$Pick_Button.AutoSize = $true
$Pick_Button.Location = [System.Drawing.Point]::new(410, 100)
$Pick_Button.DialogResult = [System.Windows.Forms.DialogResult]::OK

##DataGridView
$dgw_Form = [System.Windows.Forms.DataGridView]::new()
$dgw_Form.AllowUserToDeleteRows = $false
$dgw_Form.AllowUserToAddRows = $false
$dgw_Form.Width = 360
$dgw_Form.Height = 200
$dgw_Form.Location = [System.Drawing.Point]::new(1,1)
#$Processes = [System.Diagnostics.Process]::GetProcesses()
$PRocessesByName = [System.Diagnostics.Process]::GetProcessesByName("chrome")
$dgw_Form.Columns.Add("ProcessName", "Process Name");
$dgw_Form.Columns.Add("ProcessId", "Process ID");
$dgw_Form.Columns.Add("MainWindowsTitle", "Window Title");

## for loop to add rows until variable i is equal to $processbyname.count 
for ($i = 0; $i -lt $PRocessesByName.Count; $i++) 
{   
    $dgw_Form.Rows.Add();
    $dgw_Form.Rows[$i].Cells["processName"].Value = $PRocessesByName[$i].ProcessName + ".exe"
    $dgw_Form.Rows[$i].Cells["processID"].Value = $PRocessesByName[$i].ID 
    $dgw_Form.Rows[$i].Cells["MainWindowsTitle"].Value = $PRocessesByName[$i].MainWindowTitle
    
}

#main form add controls and buttons
$Main_Form.Controls.Add($dgw_Form)
$Main_Form.Controls.Add($Pick_Button)
$Main_Result = $Main_Form.ShowDialog()

## clicking on "בחר"
if ($Main_Result -eq "OK") { ActionClicker }
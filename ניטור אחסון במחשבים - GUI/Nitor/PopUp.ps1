
function PopUpResize
{
$PopUp_Form = New-Object System.Windows.Forms.Form
$PopUp_Form.Width = 400
$PopUp_Form.Height = 120
$PopUp_Form.StartPosition = "CenterScreen"
$PopUp_Form.Text = "צמצום בחירה"
$PopUp_Form.BackColor = "White"
$PopUp_Form.FormBorderStyle = "FixedDialog"


#$img1 = [System.Drawing.Image]::FromFile(".\spinner.gif")

$PopUP_Logo = New-Object System.Windows.Forms.PictureBox
$PopUP_Logo.Width = $img1.Size.Width
$PopUP_Logo.Height = $img1.Size.Height
$PopUP_Logo.Image = $img1
$PopUP_Logo.Location = New-Object System.Drawing.point(1,1)

$PopUp_ProgressBar = [System.Windows.Forms.ProgressBar]::new()
$PopUp_ProgressBar.Name = "בודק..."
$PopUp_ProgressBar.Value = 0
$PopUp_ProgressBar.Style = "Continuous"
$PopUp_ProgressBar.Location = [System.Drawing.Point]::new(80, 25)
$PopUp_ProgressBar.Width = 300

$PopUp_Form.Controls.Add($PopUp_Label)
$PopUp_Form.Controls.Add($PopUp_ProgressBar)
$PopUp_Form.Controls.Add($PopUP_Logo)

$PopUp_Form.Show() | Out-Null
$PopUp_Form.Focus() | Out-Null

$Counter = 0; 
$OU_AliveComputers = @()
$ResizeChoose = $Resize_ListBox.SelectedItem
$test = Get-ADComputer -Filter * -SearchBase "OU=Computers,OU=$ResizeChoose,DC=gov,DC=il" | Select -ExpandProperty Name
ForEach ($Computer in $test) 
{
      $Counter++

      [int]$Percentage = ($Counter/$test.Count) * 100;

      $PopUp_ProgressBar.Value = $Percentage

      $PopUp_Form.Refresh()

      if ((Test-Connection -ComputerName $Computer -Count 1 -Quiet) -eq $true) 
      {
        $diskQ = Invoke-Command -ComputerName $Computer -WarningAction SilentlyContinue -ScriptBlock { Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" }
        $Size = $diskQ.Size / 1GB
        $Free = $diskQ.FreeSpace / 1GB
        $Used = $size - $Free
        if ($free -lt "20") { $OU_AliveComputers += $Computer }
      }
}

$PopUp_Form.Close()
}


function PopUp
{
$PopUp_Form = New-Object System.Windows.Forms.Form
$PopUp_Form.Width = 400
$PopUp_Form.Height = 120
$PopUp_Form.StartPosition = "CenterScreen"
$PopUp_Form.Text = "צמצום בחירה"
$PopUp_Form.BackColor = "White"
$PopUp_Form.FormBorderStyle = "FixedDialog"

#$img1 = [System.Drawing.Image]::FromFile(".\spinner.gif")

$PopUP_Logo = New-Object System.Windows.Forms.PictureBox
$PopUP_Logo.Width = $img1.Size.Width
$PopUP_Logo.Height = $img1.Size.Height
$PopUP_Logo.Image = $img1
$PopUP_Logo.Location = New-Object System.Drawing.point(1,1)

$PopUp_ProgressBar = [System.Windows.Forms.ProgressBar]::new()
$PopUp_ProgressBar.Name = "בודק..."
$PopUp_ProgressBar.Value = 0
$PopUp_ProgressBar.Style = "Continuous"
$PopUp_ProgressBar.Location = [System.Drawing.Point]::new(80, 25)
$PopUp_ProgressBar.Width = 300

$PopUp_Form.Controls.Add($PopUp_Label)
$PopUp_Form.Controls.Add($PopUp_ProgressBar)
$PopUp_Form.Controls.Add($PopUP_Logo)

$PopUp_Form.Show() | Out-Null
$PopUp_Form.Focus() | Out-Null

$Counter = 0; 
$ChooseNitor = $Nitor_ComboBox.SelectedItem
$test = Get-ADComputer -Filter * -SearchBase "OU=Computers,OU=$ChooseNitor,DC=gov,DC=il" | Select -ExpandProperty Name
$OU_AliveComputers = @()
$OU_DontHaveSpaceDisk = @()
$OU_OffComputers = @()

ForEach ($Computer in $test) 
{
      $Counter++

      [int]$Percentage = ($Counter/$test.Count) * 100;

      $PopUp_ProgressBar.Value = $Percentage

      $PopUp_Form.Refresh()

      if ((Test-Connection -ComputerName $Computer -Count 1 -Quiet) -eq $true) 
      {
        $diskQ = Invoke-Command -ComputerName $Computer -WarningAction SilentlyContinue -ScriptBlock { Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" }
        $Size = $diskQ.Size / 1GB
        $Free = $diskQ.FreeSpace / 1GB
        $Used = $size - $Free
        if ($free -lt "20") { $OU_AliveComputers += $Computer }
      }

      
}

$PopUp_Form.Close()
}

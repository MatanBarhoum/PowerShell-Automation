function PopUp 
{
$PopUp_Form = New-Object System.Windows.Forms.Form
$PopUp_Form.Width = 400
$PopUp_Form.Height = 120
$PopUp_Form.StartPosition = "CenterScreen"
$PopUp_Form.Text = "צמצום בחירה"
$PopUp_Form.BackColor = "White"
$PopUp_Form.FormBorderStyle = "FixedDialog"


$img1 = [System.Drawing.Image]::FromFile(".\spinner.gif")

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
$PopUp_Form.ShowDialog()
}
PopUp
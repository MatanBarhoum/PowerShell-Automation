Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot "Weco Install Status.ps1")
. (Join-Path $PSScriptRoot "Weco Working Installer.ps1")
. (Join-Path $PSScriptRoot "Enable PS Remoting.ps1")
. (Join-Path $PSScriptRoot ".Net Version.ps1")
$Main_Form = New-Object System.Windows.Forms.Form
$Main_Form.Width = 600
$Main_Form.Height = 200
$Main_Form.Text = "We-Co Check Program"
$Main_Form.StartPosition = "CenterScreen"

$Status = New-Object System.Windows.Forms.Button
$Status.Text = "בדיקה"
$Status.Location = New-Object System.Drawing.Point(430,50)
$Status.Size = New-Object System.Drawing.Size(100,50)
$Status.Font = [System.Drawing.Font]::New("Arial", 11.5, [System.Drawing.FontStyle]::Bold)
$Main_Form.Controls.Add($Status)


$Install = New-Object System.Windows.Forms.Button
$Install.Text = "התקנה"
$Install.Location = New-Object System.Drawing.Point(250,50)
$Install.Size = New-Object System.Drawing.Size(100,50)
$Install.Font = [System.Drawing.Font]::New("Arial", 11.5, [System.Drawing.FontStyle]::Bold)
$Main_Form.Controls.Add($Install)

$PSRemoting = New-Object System.Windows.Forms.Button
$PSRemoting.Text = "PS-Remote"
$PSRemoting.Location = New-Object System.Drawing.Point(70,50)
$PSRemoting.Size = New-Object System.Drawing.Size(100,50)
$PSRemoting.Font = [System.Drawing.Font]::New("Arial", 11.5, [System.Drawing.FontStyle]::Bold)
$Main_Form.Controls.Add($PSRemoting)

$DotNetVer = New-Object System.Windows.Forms.Button
$DotNetVer.Text = ".Net Version Check"
$DotNetVer.Location = New-Object System.Drawing.Point(200,120)
$DotNetVer.Size = New-Object System.Drawing.Size(200,30)
$DotNetVer.Font = [System.Drawing.Font]::New("Arial", 11.5, [System.Drawing.FontStyle]::Bold)
$Main_Form.Controls.Add($DotNetVer)

$Status.Add_Click{

$Status_Form.ShowDialog()

}

$Install.Add_Click{
$Install_Form.ShowDialog()
}

$PSRemoting.Add_Click{
$PS_Form.ShowDialog()
}

$DotNetVer.Add_Click{
$DotNet_Form.ShowDialog()
}

$Main_Form.ShowDialog()




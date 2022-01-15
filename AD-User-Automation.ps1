Import-Module ActiveDirectory

$Domain="@gov.il"

$NewUsersList=Import-CSV "C:\list.csv"

ForEach ($user in $NewUsersList)

{

$FullName=$User.FullName

$Company=$User.Company

$Department=$User.department

$Description=$User.Description

$GivenName=$User.GivenName

$title=$user.title

$city=$user.city

$telephonenumber=$user.telephoneNumber

$sAMAccountName=$user.sAMAccountName

$sn=$User.sn

$userprincipalName=$user.sAMAccountName+$Domain

$userPassword=$user.Password

$expire=$null

if ($Department -eq "HelpDesk" ) { $UserOu = "OU=Users,OU=HelpDesk,DC=gov,DC=il" }
if ($Department -eq "Finance" ) { $UserOu = "OU=Users,OU=Finance,DC=gov,DC=il" }
if ($Department -eq "Siyua" ) { $UserOu = "OU=Users,OU=Siyua,DC=gov,DC=il" }
if ($Department -eq "Management" ) { $UserOu = "OU=Users,OU=Management,DC=gov,DC=il" }


New-ADUser -Path $UserOu -Enabled $True -ChangePasswordAtLogon $True -AccountPassword (ConvertTo-SecureString $userPassword -AsPlainText -Force) -City $city -Company $Company -Department $Department -title $title -OfficePhone $telephoneNumber -DisplayName $FullName -GivenName $givenName -Name $fullname -SamAccountName $sAMAccountName -Surname $sn -UserPrincipalName $userprincipalName }

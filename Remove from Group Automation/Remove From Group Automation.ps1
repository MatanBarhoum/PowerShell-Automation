$PermUsers = @(<names>);
$Users = Get-ADGroupMember -Identity <GroupName> | Select -ExpandProperty SamAccountName


for ($i = 0; $i -lt $Users.Count; $i++)
{
    for ($j = 0; $j -lt $PermUsers.Count; $j++)
    {
        if ($PermUsers -notcontains $Users[$i]) { Remove-ADGroupMember -Identity "Smart Card-Non Require" -Members $Users[$i] -Confirm:$false; break; }
    }
}

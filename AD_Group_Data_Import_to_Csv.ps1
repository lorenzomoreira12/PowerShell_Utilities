Import-Module ActiveDirectory

$grupo = "Group_name"
$saida = @()

Get-ADGroupMember -Identity $grupo -Recursive |
Where-Object { $_.objectClass -eq 'user' } |
ForEach-Object {
    $user = Get-ADUser $_.DistinguishedName -Properties `
        SamAccountName, DisplayName, EmailAddress, LastLogonDate,
        Company, Department, Title, l, physicalDeliveryOfficeName, Description

    $saida += [PSCustomObject]@{
        SamAccountName              = $user.SamAccountName
        DisplayName                 = $user.DisplayName
        EmailAddress                = $user.EmailAddress
        LastLogonDate               = $user.LastLogonDate
        Company                     = $user.Company
        Department                  = $user.Department
        Title                       = $user.Title
        City                        = $user.l
        Office                      = $user.physicalDeliveryOfficeName
        Description                 = $user.Description
    }
}

$saida | Export-Csv -Path "C:\Group_data_sheet.csv" -NoTypeInformation -Encoding UTF8

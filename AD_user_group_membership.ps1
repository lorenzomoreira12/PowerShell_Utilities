Import-Module ActiveDirectory

$usuario = "user name"

$caminhoSaida = "C:\$usuario.txt"

$grupos = Get-ADPrincipalGroupMembership -Identity $usuario |
          Select-Object -ExpandProperty Name |
          Sort-Object

$grupos | Out-File -FilePath $caminhoSaida -Encoding UTF8

Write-Host "File at: $caminhoSaida"


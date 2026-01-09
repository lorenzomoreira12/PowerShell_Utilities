<#
.SYNOPSIS
    Verifica a existência de valores duplicados em atributos específicos do Active Directory.
    
.DESCRIPTION
    Este script varre o AD em busca de usuários que possuam um valor específico em um atributo definido (ex: employeeType, employeeID, extensionAttribute1).
    Útil para auditoria de RH e resolução de conflitos de sincronização.

.EXAMPLE
    .\Check-ADAttribute.ps1 -AttributeName "employeeType" -SearchValue "1100289011"
#>

Param(
    [Parameter(Mandatory=$true)]
    [string]$AttributeName,

    [Parameter(Mandatory=$true)]
    [string]$SearchValue
)

Process {
    Write-Host "Insira dos dados para busca" -ForegroundColor Cyan
    Write-Host "Campo: $AttributeName | Valor: $SearchValue" -ForegroundColor Gray

    try {
        # Busca usuários que possuem QUALQUER valor no atributo especificado
        $allUsers = Get-ADUser -Filter "$AttributeName -like '*'" -Properties $AttributeName -ErrorAction Stop
        
        # Filtra localmente para garantir precisão (ignora espaços em branco)
        $matches = $allUsers | Where-Object { $_.$AttributeName.ToString().Trim() -eq $SearchValue.Trim() }

        if ($matches) {
            $count = ($matches | Measure-Object).Count
            if ($count -gt 1) {
                Write-Host "Encontradas $count duplicatas!" -ForegroundColor Red
                $matches | Select-Object Name, SamAccountName, $AttributeName | Format-Table -AutoSize
            } else {
                Write-Host "Valor único no AD." -ForegroundColor Green
                $matches | Select-Object Name, SamAccountName, $AttributeName | Format-Table -AutoSize
            }
        } else {
            Write-Host "Nenhum usuário encontrado com este valor." -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "ERRO: Certifique-se de que o nome do atributo '$AttributeName' está correto e que você tem permissão de leitura." -ForegroundColor Red
    }
    Write-Host "`nProcesso concluído." -ForegroundColor Gray
Read-Host "Pressione ENTER para sair"
}


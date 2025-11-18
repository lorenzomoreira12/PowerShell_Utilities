@echo off
title Servicedesk
color 0A

:menu
cls
echo ========= Servicedesk  =========
echo 0  - Sair
echo 1  - Apagar Arquivos Temporarios (Temp e Prefetch)
echo 2  - Gerenciador de Tarefas
echo 3  - Adicionar ou Remover Programas
echo 4  - Limpeza de Disco
echo 5  - Gerenciamento de Usuarios de Rede (Dominio)
echo 6  - Listar Sessoes Ativas
echo 7  - Reparar Microsoft Edge
echo 8  - Reparar Google Chrome
echo 9  - Reparar Microsoft Teams
echo 10 - Atualizar GPO
echo 11 - Resolver Problemas de Audio
echo 12 - Restaurar o Windows
echo 13 - Limpar cache de atualizacoes antigas
echo 14 - Diagnostico de Rede
echo 15 - Atualizar Windows
echo ===========================================
set /p opcao=Escolha uma opcao: 

if "%opcao%"=="0"  goto sair
if "%opcao%"=="1"  goto lentidao
if "%opcao%"=="2"  goto taskmanager
if "%opcao%"=="3"  goto apps
if "%opcao%"=="4"  goto cleanmgr
if "%opcao%"=="5"  goto usuarios
if "%opcao%"=="6"  goto usuariosLogados
if "%opcao%"=="7"  goto repararEdge
if "%opcao%"=="8"  goto repararChrome
if "%opcao%"=="9"  goto repararTeams
if "%opcao%"=="10" goto updateGp
if "%opcao%"=="11" goto audio
if "%opcao%"=="12" goto restorehealth
if "%opcao%"=="13" goto componentcleanup
if "%opcao%"=="14" goto rede
if "%opcao%"=="15" goto atualizarWindows

echo Opcao invalida.
pause
goto menu

:: =================== Servicedesk ===================
:lentidao
cls
echo Encerrando processos que usam arquivos temporarios...
taskkill /f /im Teams.exe >nul 2>&1
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
timeout /t 2 >nul

echo Limpando %TEMP%...
del /f /s /q "%TEMP%\*.*"
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i"

echo Limpando C:\Windows\Temp...
del /f /s /q "C:\Windows\Temp\*.*"
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i"

echo Limpando C:\Windows\Prefetch...
del /f /s /q "C:\Windows\Prefetch\*.*"

echo Limpando cache da Microsoft Store...
del /f /s /q "%LocalAppData%\Packages\Microsoft.WindowsStore_*\LocalCache\*.*"

echo Limpando arquivos temporários do perfil do usuário...
for /r "%userprofile%" %%f in (*.tmp *.log) do del /f /q "%%f"

echo.
echo Limpeza concluída com sucesso.
pause
goto menu

:cleanmgr
cleanmgr
echo.
echo Janela Aberta, retorne ao menu.
pause
goto menu

:audio
cls

echo Reiniciando servicos de audio     

echo Encerrando apps relacionados...
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im Teams.exe >nul 2>&1

echo Reiniciando servicos...
powershell -Command "Restart-Service -Name 'Audiosrv' -Force"
powershell -Command "Restart-Service -Name 'AudioEndpointBuilder' -Force"

echo.
echo Servicos de audio reiniciados com sucesso.
pause
goto menu



:updateGp 
gpupdate /force
pause
goto menu

:repararEdge
cls
echo Encerrando Microsoft Edge...
taskkill /f /im msedge.exe >nul 2>&1

echo.
echo Limpando cache do Microsoft Edge...
rd /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Cache" 2>nul
rd /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Code Cache" 2>nul

echo.
echo Edge reparado.
pause
goto menu

:repararTeams
cls
echo Encerrando Microsoft Teams...
taskkill /f /im Teams.exe >nul 2>&1
taskkill /f /im Update.exe >nul 2>&1
taskkill /f /im ms-teams.exe >nul 2>&1

echo.
echo Limpando arquivos do Teams...
rd /s /q "%userprofile%\AppData\Roaming\Microsoft\Teams" 2>nul
rd /s /q "%userprofile%\AppData\Local\Microsoft\Teams" 2>nul
rd /s /q "%userprofile%\AppData\Local\SquirrelTemp" 2>nul

echo.
echo Microsoft Teams reparado.
pause
goto menu

:repararChrome
cls
echo Encerrando Google Chrome...
taskkill /f /im chrome.exe >nul 2>&1

echo.
echo Limpando cache do Chrome...
rd /s /q "%userprofile%\AppData\Local\Google\Chrome\User Data\Default\Cache" 2>nul
rd /s /q "%userprofile%\AppData\Local\Google\Chrome\User Data\Default\Code Cache" 2>nul

echo.
echo Chrome reparado.
pause
goto menu


:: ================= Servicedesk =================

:rede
cls
echo ============ Servicedesk =============
echo 0 - Voltar para o menu inicial
echo 1 - Verificar informacoes completas da rede
echo 2 - Flush DNS
echo 3 - Ping Servidor
echo 4 - Rotas de rede
echo 5 - Resetar TCP/IP
echo =============================================
set /p opcao=Escolha uma opcao: 

if "%opcao%"=="0" goto menu
if "%opcao%"=="1" goto ipall
if "%opcao%"=="2" goto flushdns
if "%opcao%"=="3" goto pingserv 
if "%opcao%"=="4" goto rotas
if "%opcao%"=="5" goto resetarwinsock
echo Opcao invalida.
pause
goto rede
:ipall
ipconfig /all
pause
goto rede

:flushdns
ipconfig /flushdns
pause
goto rede

:pingserv
set /p ipNome=Digite o nome ou IP do Servidor:
ping %ipNome%
pause
goto rede

:rotas
route print
pause
goto rede

:resetarwinsock
netsh winsock reset
pause
goto rede

echo.
echo Limpando cache do Microsoft Edge...
rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache"
rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Code Cache"

echo.
echo Edge reparado. Reabra o navegador se necessario.
pause
goto menu

:apps
start ms-settings:appsfeatures
echo Abrindo Adicionar ou Remover Programas...
pause
goto menu

:taskmanager
start taskmgr
echo Abrindo o Gerenciador de Tarefas...
pause
goto menu

:usuarios
control.exe sysdm.cpl,,3
echo Abrindo aba de gerenciamento de usuarios...
pause
goto menu

:componentcleanup
cls
echo Abrindo nova janela do PowerShell para executar:
echo DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase
start "DISM ComponentCleanup" powershell -NoExit -Command "DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase"
echo.
echo O comando esta sendo executado em outra janela. Voce pode continuar usando o menu.
pause
goto menu

:restorehealth
cls
echo Abrindo nova janela do PowerShell para executar:
echo DISM /Online /Cleanup-Image /RestoreHealth
start powershell -NoExit -Command "DISM /Online /Cleanup-Image /RestoreHealth"
echo.
echo O comando esta sendo executado em outra janela. Voce pode continuar usando o menu.
pause
goto menu

:usuariosLogados
cls
echo ========== Servicedesk ==========
quser
echo.
set /p logoffID=Digite o ID da sessao que deseja fazer logoff (ou deixe em branco para cancelar): 
if not "%logoffID%"=="" (
    logoff %logoffID%
    echo Sessao %logoffID% encerrada.
) else (
    echo Nenhuma sessao foi encerrada.
)
pause
goto menu

:atualizarWindows
cls
echo Atualizando o Windows...
echo.

echo Verificando atualizacoes...
powershell -command "UsoClient StartScan"
timeout /t 2 >nul

echo Baixando atualizacoes...
powershell -command "UsoClient StartDownload"
timeout /t 2 >nul

echo Instalando atualizacoes...
powershell -command "UsoClient StartInstall"

echo.
echo Atualizacoes em andamento. Verifique o Windows Update para progresso.
pause
goto menu


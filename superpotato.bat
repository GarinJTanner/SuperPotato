@echo off
title SuperPotato - Performance Booster
color 0a
set runTime=0
setlocal enabledelayedexpansion

if not exist %appdata%\potato md %appdata%\potato

if not exist %appdata%\potato\spudlist.txt (
    echo conhost.exe> %appdata%\potato\spudlist.txt
    echo cmd.exe>> %appdata%\potato\spudlist.txt
    echo explorer.exe>> %appdata%\potato\spudlist.txt
    echo notepad++.exe>> %appdata%\potato\spudlist.txt
    echo powershell.exe>> %appdata%\potato\spudlist.txt
    echo sndvol.exe>> %appdata%\potato\spudlist.txt
    echo svchost.exe>> %appdata%\potato\spudlist.txt
    echo tasklist.exe>> %appata%\potato\spudlist.txt
 )

if not exist %appdata%\potato\taskkill.ps1 (
copy /y %myfiles%\taskkill.ps1 %appdata%\potato\taskkill.ps1
)

if exist %appdata%\potato\tasklist.txt (
    del %appdata%\potato\tasklist.txt
)

if not exist %appdata%\potato\spudhistory.txt (
copy /y %myfiles%\history2.ps1 %appdata%\potato\history2.ps1)

Echo.
ECHO            BY USING THIS SOFTWARE, YOU AGREE THAT
ECHO.
echo          Garin J. Tanner SHALL IN NO EVENT BE LIABLE 
echo.
echo            FOR ANY LOSS OF GOODWILL, WORK STOPPAGE, 
echo.
echo         COMPUTER FAILURE OR MALFUNCTION, LOST PROFITS,
Echo.
echo        LOSS OF INFORMATION OR DATA, SPECIAL, INCIDENTAL, 
echo.
echo        INDIRECT, PUNITIVE OR CONSEQUENTIAL OR INCIDENTAL 
echo.
echo         DAMAGES, ARISING IN ANY WAY OUT OF YOUR USE OF 
ECHO.
ECHO               OR INABILITY TO USE THE SOFTWARE.
ECHO.
echo              1. Agree to the above and continue
echo              2. Disagree to the above and quit

    CHOICE /C 12>nul

    IF ERRORLEVEL 2 exit


cls
echo.
echo               ::::::PLEASE SAVE YOUR WORK::::::
echo.
echo           ALL PROGRAMS THAT ARE NOT ON THE SAFELIST
ECHO.
echo                       -WILL BE CLOSED-
echo.
ECHO               USE THIS PROGRAM AT YOUR OWN RISK
ECHO.
ECHO.
echo               1. View safelist
echo               2. Quit program
echo               3. SuperPotato

CHOICE /C 123>nul

IF ERRORLEVEL 3 GOTO EULAagree
IF ERRORLEVEL 2 exit
IF ERRORLEVEL 1 GOTO EULAspudlist

:EULAspudlist
cls
start "" /separate "%appdata%\potato\spudlist.txt"
GOTO EULA


:EULAagree


for /f "skip=3 delims= " %%i in ('TASKLIST /FI "USERNAME eq %userdomain%\%username%" /FI "STATUS eq running"') do (
echo %%i>> %appdata%\potato\tasklist.txt
)



:PotatoKill
cls
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File "%appdata%\potato\taskkill.ps1"' -Verb RunAs}"
if %runTime%=="1" GOTO PotatoStart ELSE (GOTO SERVICEKILL)



:SERVICEKILL
sc stop wuauserv>nul                
sc stop Schedule>nul
set runTime=1



:PotatoStart
echo.
echo     .  '  '   .   .   .  .
echo    .                       '
echo   .                         '
echo   .       SuperPotato       '
echo    .                        '
echo     .                     .'
echo       '  .   .   .   .  '
echo.
echo     1. Search game  
echo     2. Last played game
echo     3. Add process to safelist
echo     4. Read safelist

CHOICE /C 1234>nul

IF ERRORLEVEL 4 GOTO viewSpudList
IF ERRORLEVEL 3 GOTO SpudList
IF ERRORLEVEL 2 GOTO LastPlayed
IF ERRORLEVEL 1 GOTO CUSTOM



:CUSTOM
cls
echo.
echo     .  '  '   .   .   .  .
echo    .                       '
echo   .                         '
echo   .       SuperPotato       '
echo    .                        '
echo     .                     .'
echo       '  .   .   .   .  '
echo.
echo     Type in the filename
echo.
echo     Examples: cuphead.exe
echo               leagueclient.exe
echo.
setlocal

SET /P custom_input= 
set "savedInput=%custom_input%"


cls
echo Loading. Please wait...

findstr /i %savedInput% %appdata%\potato\spudhistory.txt

IF ERRORLEVEL 1 GOTO CREATELINK

setlocal enabledelayedexpansion 
    for /f "usebackq tokens=2 delims=," %%i in (%appdata%\potato\spudhistory.txt) do start "" /separate /high "%%i" & echo %%i>%appdata%\potato\LastPlayed.txt & GOTO startMenu
    

:CREATELINK
for %%i in (c d e f g h i j k l m n o p q r s t u v w x y z) do (
for /f "tokens=*" %%a in ('dir /b /o:-d /s /a-d %%i:\"%savedInput%" 2^>nul') do echo %%a>%appdata%\potato\LastPlayed.txt & echo %savedInput%,%%a>>%appdata%\potato\spudhistory.txt & start "" /separate /high "%%a" & GOTO startMenu
)

echo File not found. Press any key to return to the main menu.
ENDLOCAL
pause>nul
GOTO PotatoStart





:LastPlayed
for /f "delims=" %%i in (%appdata%\potato\lastplayed.txt) do set "lastplayed=%%i"
start "" /separate /high "%lastplayed%"
GOTO startMenu



:SpudList
cls
echo.
echo     .  '  '   .   .   .  .
echo    .                       '
echo   .                         '
echo   .       SuperPotato       '
echo    .                        '
echo     .                     .'
echo       '  .   .   .   .  '
echo.
echo    Type in the process name:
SET /P custom_input= 
echo %custom_input%>> %appdata%\potato\spudlist.txt
cls



:viewSpudList
cls
start "" /separate "%appdata%\potato\spudlist.txt"
GOTO PotatoStart


:startMenu
cls
echo.
echo     .  '  '   .   .   .  .
echo    .                       '
echo   .                         '
echo   .       SuperPotato       '
echo    .                        '
echo     .                     .'
echo       '  .   .   .   .  '
echo.
echo     1. Internet
echo     2. New Game
echo     3. Donation
echo     4. Explorer
echo     5. Sign out
echo     6. Shutdown
echo.
echo.
echo    Send Feedback! GarinJTanner@gmail.com


choice /c 123456>nul

IF ERRORLEVEL 6 GOTO Shutdown
IF ERRORLEVEL 5 GOTO logoff
IF ERRORLEVEL 4 GOTO Windows
IF ERRORLEVEL 3 GOTO donate
IF ERRORLEVEL 2 GOTO PotatoKill
IF ERRORLEVEL 1 GOTO Firefox



:Firefox
cls
start www.google.com
GOTO startMenu



:Windows
cls
start "" explorer
GOTO startMenu



:Shutdown
cls
shutdown /p /f

:logoff
cls
shutdown /l /f


:donate
cls
start www.paypal.me/garinjtanner
GOTO startMenu

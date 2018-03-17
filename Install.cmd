@echo off

:: For start menu and desktop shortcuts
set appStartMenuFolder=Keepass
set appName=Keepass

set appExePath=%cd%\Keepass.exe
set appIconPath=%appExePath%

set appHotkey=ALT+CTRL+SHIFT+X

::==========================================
:: [ Install Application ]
::==========================================
echo - Creating Desktop shortcuts...
call :CreateDesktopShortcut

echo - Creating Start Menu shortcuts...
call :CreateStartMenuShortcut

::==========================================
:: [ Exit Installer ]
::==========================================
echo Installation Completed!

:end
echo.
echo The installer will now exit.
pause
exit /b
goto:eof

:: =================================================================================================================================
:: =================================================================================================================================
:: =================================================================================================================================

::==========================================
:: Functions
::==========================================
:CreateDesktopShortcut
  echo   - Creating desktop shortcut for %appName%...

  echo Set oWS = WScript.CreateObject("WScript.Shell") > "%temp%\CreateShortcut.vbs"
  (
    echo sLinkFile = "%userprofile%\Desktop\%appName%.lnk"
    echo Set oLink = oWS.CreateShortcut^(sLinkFile^)
    echo oLink.TargetPath = "%appExePath%"

    echo oLink.IconLocation = "%appIconPath%"
    echo oLink.HotKey = "%appHotkey%"
    echo oLink.Save
  ) >> "%temp%\CreateShortcut.vbs"

  rem Extras
  rem echo oLink.Arguments = "/c "+"""%appExePath%"""
  rem oLink.WindowStyle = "1"
  rem oLink.WorkingDirectory = "C:\Program Files\MyApp"
  rem oLink.Description = "MyProgram"

  cscript "%temp%\CreateShortcut.vbs" > nul
  del "%temp%\CreateShortcut.vbs" > nul
goto:eof

:CreateStartMenuShortcut
  echo   - Creating Start Menu entry for %appName%...
  if not exist "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\%appStartMenuFolder%" ( mkdir "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\%appStartMenuFolder%" )
  del "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\%appStartMenuFolder%\%appName%.lnk" > nul

  echo Set oWS = WScript.CreateObject("WScript.Shell") > "%temp%\CreateShortcut.vbs"
  (
    echo sLinkFile = "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\%appStartMenuFolder%\%appName%.lnk"
    echo Set oLink = oWS.CreateShortcut^(sLinkFile^)
    echo oLink.TargetPath = "%appExePath%"
    echo oLink.IconLocation = "%appIconPath%"
    echo oLink.Save
  ) >> "%temp%\CreateShortcut.vbs"

  cscript "%temp%\CreateShortcut.vbs" > nul
  del "%temp%\CreateShortcut.vbs" > nul
goto:eof
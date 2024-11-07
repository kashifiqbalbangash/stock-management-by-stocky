@echo off
echo Starting WAMP server...
start "" "C:\wamp64\wampmanager.exe"  // Adjust path if needed

echo Waiting for WAMP to fully start...

:CheckWAMP
ping -n 6 127.0.0.1 >nul  // Waits ~5 seconds before each check
sc query wampapache64 | find "RUNNING" >nul

if errorlevel 1 (
    echo WAMP is still starting, checking again...
    goto :CheckWAMP
) else (
    echo WAMP has started successfully.
)

echo Starting Laravel server...
start php artisan serve

echo Waiting for Laravel server to start...

:CheckLaravel
ping -n 6 127.0.0.1 >nul  // Waits ~5 seconds before each check
curl -s http://localhost:8000 >nul

if errorlevel 1 (
    echo Laravel is still starting, checking again...
    goto :CheckLaravel
) else (
    echo Laravel server has started successfully.
    echo Opening application in the default browser...
    start http://localhost:8000
)

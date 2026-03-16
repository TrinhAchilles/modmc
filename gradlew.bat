@echo off
setlocal enabledelayedexpansion

echo.
echo ============================================================
echo   TacticalBoss Mod - Gradle Wrapper (Windows)
echo ============================================================
echo.

:: ── 1. Thu wrapper JAR neu co ────────────────────────────────────────────
set WRAPPER_JAR=%~dp0gradle\wrapper\gradle-wrapper.jar
if exist "%WRAPPER_JAR%" (
    java -classpath "%WRAPPER_JAR%" org.gradle.wrapper.GradleWrapperMain %*
    exit /b %errorlevel%
)

:: ── 2. Thu Gradle cai san ────────────────────────────────────────────────
where gradle >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=2" %%v in ('gradle --version 2^>nul ^| findstr /i "Gradle "') do (
        set GRADLE_VER=%%v
        echo [gradlew] Tim thay Gradle !GRADLE_VER! tren he thong.
        gradle %*
        exit /b %errorlevel%
    )
)

:: ── 3. Thu GRADLE_HOME ───────────────────────────────────────────────────
if defined GRADLE_HOME (
    if exist "%GRADLE_HOME%\bin\gradle.bat" (
        echo [gradlew] Dung GRADLE_HOME: %GRADLE_HOME%
        "%GRADLE_HOME%\bin\gradle.bat" %*
        exit /b %errorlevel%
    )
)

:: ── 4. Tu tai wrapper JAR neu co internet ────────────────────────────────
echo [gradlew] Dang thu tai gradle-wrapper.jar...
set WRAPPER_URL=https://raw.githubusercontent.com/gradle/gradle/v8.8.0/gradle/wrapper/gradle-wrapper.jar
set WRAPPER_DEST=%~dp0gradle\wrapper\gradle-wrapper.jar

if not exist "%~dp0gradle\wrapper" mkdir "%~dp0gradle\wrapper"

powershell -Command "try { Invoke-WebRequest -Uri '%WRAPPER_URL%' -OutFile '%WRAPPER_DEST%' -TimeoutSec 30 -ErrorAction Stop; Write-Host 'Tai thanh cong!' } catch { exit 1 }" 2>nul
if exist "%WRAPPER_DEST%" (
    echo [gradlew] Tai thanh cong! Dang build...
    java -classpath "%WRAPPER_DEST%" org.gradle.wrapper.GradleWrapperMain %*
    exit /b %errorlevel%
)

:: ── 5. Huong dan cai dat ─────────────────────────────────────────────────
echo.
echo ============================================================
echo   CAN CAI GRADLE DE BUILD MOD NAY
echo ============================================================
echo.
echo   Chon mot trong cac cach sau:
echo.
echo   A) Scoop (Windows, de nhat):
echo      scoop install gradle
echo.
echo   B) Winget:
echo      winget install Gradle.Gradle
echo.
echo   C) Chocolatey:
echo      choco install gradle
echo.
echo   D) Tai thu cong tu:
echo      https://gradle.org/releases/
echo      Giai nen ^> them vao PATH
echo.
echo   E) Dung IntelliJ IDEA (co Gradle tich hop san):
echo      File ^> Open ^> chon thu muc tacticalboss\
echo      Bam nut Build la xong
echo.
echo   Sau khi cai xong, chay lai: build_windows.bat
echo.
pause
exit /b 1

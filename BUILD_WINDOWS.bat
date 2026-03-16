@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
title TacticalBoss Mod Builder

echo.
echo ╔══════════════════════════════════════════════════╗
echo ║       TacticalBoss Mod - Auto Build v2           ║
echo ║             Fabric 1.21.1                        ║
echo ╚══════════════════════════════════════════════════╝
echo.

:: ── Kiem tra Java ────────────────────────────────────────────────────────
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [LOI] Khong tim thay Java 21!
    echo.
    echo   Tai Java 21 tai: https://adoptium.net/
    echo   Chon: Temurin 21 LTS - Windows x64 Installer
    echo.
    pause & exit /b 1
)
echo [OK] Java tim thay.

:: ── Chay build ───────────────────────────────────────────────────────────
echo [INFO] Bat dau build...
echo.
call gradlew.bat build --no-daemon --stacktrace

if %errorlevel% equ 0 (
    echo.
    echo ╔══════════════════════════════════════════════════╗
    echo ║            BUILD THANH CONG!                     ║
    echo ╠══════════════════════════════════════════════════╣
    echo ║  File: build\libs\tacticalboss-1.0.0.jar         ║
    echo ║  Copy vao: .minecraft\mods\                      ║
    echo ║  Spawn:  /summon tacticalboss:tactical_boss      ║
    echo ╚══════════════════════════════════════════════════╝
    echo.
    :: Mo thu muc output tu dong
    explorer build\libs 2>nul
) else (
    echo.
    echo [LOI] Build that bai!
    echo Xem log phia tren de biet loi cu the.
    echo.
    echo Loi pho bien:
    echo   - Chua cai Gradle: chay gradlew.bat truoc
    echo   - Java version sai: can Java 21+
    echo   - Fabric API thieu: kiem tra ket noi mang lan dau build
    echo.
)
pause

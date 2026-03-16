#!/usr/bin/env bash
set -e

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║       TacticalBoss Mod - Auto Build v2           ║"
echo "║             Fabric 1.21.1                        ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# ── Kiem tra Java ─────────────────────────────────────────────────────────
if ! command -v java &>/dev/null; then
    echo "[LOI] Khong tim thay Java 21!"
    echo ""
    echo "  Cai Java 21:"
    echo "  - macOS:  brew install --cask temurin@21"
    echo "  - Ubuntu: sudo apt install openjdk-21-jdk"
    echo "  - SDKMAN: sdk install java 21-tem"
    exit 1
fi

JAVA_VER=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d. -f1)
echo "[OK] Java $JAVA_VER tim thay."

chmod +x gradlew

echo "[INFO] Bat dau build..."
echo ""
./gradlew build --no-daemon --stacktrace

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║            BUILD THANH CONG!                     ║"
echo "╠══════════════════════════════════════════════════╣"
echo "║  File: build/libs/tacticalboss-1.0.0.jar         ║"
echo "║  Copy vao: ~/.minecraft/mods/                    ║"
echo "║  Spawn:  /summon tacticalboss:tactical_boss      ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

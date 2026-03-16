#!/usr/bin/env sh

##############################################################################
# TacticalBoss - Gradle Wrapper Script (Linux / macOS)
#
# Script này tự động tìm Gradle trên máy bạn.
# Nếu không tìm thấy, nó hướng dẫn cài đặt.
##############################################################################

set -e

GRADLE_MIN_VERSION=8

# ── 1. Thử dùng wrapper JAR nếu có ─────────────────────────────────────────
WRAPPER_JAR="$(dirname "$0")/gradle/wrapper/gradle-wrapper.jar"
if [ -f "$WRAPPER_JAR" ]; then
    exec java -classpath "$WRAPPER_JAR" \
        org.gradle.wrapper.GradleWrapperMain "$@"
fi

# ── 2. Thử dùng Gradle được cài sẵn trên hệ thống ──────────────────────────
if command -v gradle >/dev/null 2>&1; then
    INSTALLED_VER=$(gradle --version 2>/dev/null | grep "^Gradle" | sed 's/Gradle //' | cut -d. -f1)
    if [ -n "$INSTALLED_VER" ] && [ "$INSTALLED_VER" -ge "$GRADLE_MIN_VERSION" ] 2>/dev/null; then
        echo "[gradlew] Dùng Gradle $INSTALLED_VER đã cài sẵn."
        exec gradle "$@"
    fi
fi

# ── 3. Thử GRADLE_HOME env ──────────────────────────────────────────────────
if [ -n "$GRADLE_HOME" ] && [ -f "$GRADLE_HOME/bin/gradle" ]; then
    echo "[gradlew] Dùng GRADLE_HOME: $GRADLE_HOME"
    exec "$GRADLE_HOME/bin/gradle" "$@"
fi

# ── 4. Tự tải gradle-wrapper.jar nếu có internet ────────────────────────────
echo "[gradlew] Đang thử tải gradle-wrapper.jar..."
WRAPPER_URL="https://raw.githubusercontent.com/gradle/gradle/v8.8.0/gradle/wrapper/gradle-wrapper.jar"
DEST="$(dirname "$0")/gradle/wrapper/gradle-wrapper.jar"
if command -v curl >/dev/null 2>&1; then
    if curl -fsSL --max-time 30 "$WRAPPER_URL" -o "$DEST" 2>/dev/null; then
        echo "[gradlew] Tải thành công! Đang chạy build..."
        exec java -classpath "$DEST" org.gradle.wrapper.GradleWrapperMain "$@"
    fi
fi
if command -v wget >/dev/null 2>&1; then
    if wget -q --timeout=30 "$WRAPPER_URL" -O "$DEST" 2>/dev/null; then
        echo "[gradlew] Tải thành công! Đang chạy build..."
        exec java -classpath "$DEST" org.gradle.wrapper.GradleWrapperMain "$@"
    fi
fi

# ── 5. Hướng dẫn cài đặt thủ công ───────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║          CẦN CÀI GRADLE ĐỂ BUILD MOD NÀY                    ║"
echo "╠══════════════════════════════════════════════════════════════╣"
echo "║  Chọn một trong các cách sau:                                ║"
echo "║                                                              ║"
echo "║  A) SDKMAN (Linux/Mac, dễ nhất):                            ║"
echo "║     curl -s https://get.sdkman.io | bash                    ║"
echo "║     sdk install gradle 8.8                                   ║"
echo "║                                                              ║"
echo "║  B) Homebrew (macOS):                                        ║"
echo "║     brew install gradle                                      ║"
echo "║                                                              ║"
echo "║  C) Tải thủ công:                                            ║"
echo "║     https://gradle.org/releases/                             ║"
echo "║     Giải nén → copy thư mục gradle/ vào PATH                 ║"
echo "║                                                              ║"
echo "║  D) Dùng IntelliJ IDEA (có Gradle tích hợp sẵn):            ║"
echo "║     File > Open > chọn thư mục tacticalboss/                 ║"
echo "║     Bấm nút Build (▶) là xong                               ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
exit 1

# ⚔ TacticalBoss Mod — Fabric 1.21.1

---

## HƯỚNG DẪN BUILD (Đọc kỹ trước khi làm)

### Bước 1 — Cài Java 21
Tải tại: **https://adoptium.net/**  
Chọn: **Temurin 21 LTS** → cài như bình thường.

---

### Bước 2 — Cài Gradle

**Cách A: IntelliJ IDEA (DỄ NHẤT — khuyên dùng)**
1. Tải IntelliJ IDEA Community (miễn phí): https://www.jetbrains.com/idea/download/
2. Mở IntelliJ → **File > Open** → chọn thư mục `tacticalboss/`
3. IntelliJ tự nhận Gradle và build — bấm nút **🔨 Build > Build Project**
4. File jar xuất hiện tại `build/libs/tacticalboss-1.0.0.jar`

**Cách B: Windows — cài Gradle qua Scoop**
```
# Mở PowerShell, chạy lần lượt:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install gradle
```
Sau đó chạy: `BUILD_WINDOWS.bat`

**Cách C: Windows — cài Gradle qua Winget**
```
winget install Gradle.Gradle
```
Sau đó chạy: `BUILD_WINDOWS.bat`

**Cách D: macOS**
```
brew install gradle
./BUILD_LINUX_MAC.sh
```

**Cách E: Ubuntu/Debian**
```
sdk install gradle 8.8    # nếu có SDKMAN
# hoặc
curl -s "https://get.sdkman.io" | bash
sdk install gradle 8.8
./BUILD_LINUX_MAC.sh
```

---

### Bước 3 — Copy jar vào Minecraft

1. Tìm file: `build/libs/tacticalboss-1.0.0.jar`
2. Copy vào thư mục `.minecraft/mods/`
3. Đảm bảo đã cài **Fabric Loader 0.16.5+** và **Fabric API 0.102.0+**

---

### Bước 4 — Spawn Boss trong Game
```
/summon tacticalboss:tactical_boss
```
Hoặc dùng **Spawn Egg** (đen/đỏ) trong Creative > Spawn Eggs.

---

## TÍNH NĂNG BOSS

| Tình huống | Hành vi |
|---|---|
| HP đầy, xa player | Bắn cung (lead prediction) |
| Tầm trung | Nỏ multishot → 3 rocket pháo hoa |
| Gần player | Kiếm + Khiên |
| Player có khiên | Rìu + Khiên (rìu vô hiệu hóa khiên!) |
| Bị tường chặn | Cuốc đập phá block |
| Player bỏ chạy | Cưỡi ngựa đuổi |
| Player lên cao | Cưỡi Phantom bay |
| Player dưới nước | Cưỡi cá heo |
| HP ≤ 50% | Dừng ăn Táo Vàng / uống Potion |
| Bất kỳ lúc nào | Ném tơ nhện + Slowness IV |
| HP ≤ 25% | Cầm Totem + Diamond armor, chạy Speed III |
| Totem kích hoạt | **TNT KAMIKAZE** — liên tục đặt TNT đồng quy |

**Texture**: Zombie vanilla (scale 1.1×)  
**HP**: 300 tim | **Boss Bar**: đỏ, 10 khắc  
**Loot**: Kim cương, Netherite, Totem, Elytra (hiếm)

---

## CẤU TRÚC SOURCE

```
src/main/java/com/tacticalboss/
├── TacticalBossMod.java
├── entity/TacticalBossEntity.java      ← Logic chính
└── entity/goal/
    ├── BossRangedAttackGoal.java        ← Cung
    ├── BossCrossbowFireworkGoal.java    ← Nỏ + pháo hoa
    ├── BossMeleeAttackGoal.java         ← Kiếm/Rìu + Khiên
    ├── BossCobwebGoal.java              ← Tơ nhện
    ├── BossHealGoal.java                ← Hồi máu
    ├── BossBreakBlockGoal.java          ← Phá block
    ├── BossMountedHorseGoal.java        ← Cưỡi ngựa
    ├── BossMountedPhantomGoal.java      ← Cưỡi Phantom
    ├── BossMountedDolphinGoal.java      ← Cưỡi cá heo
    ├── BossFleeWithTotemGoal.java       ← Chạy + Totem
    └── BossKamikazeTntGoal.java         ← TNT Kamikaze
```

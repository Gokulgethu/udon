# Universal Custom ROM Device Tree for OnePlus 11R 5G (`udon` / `CPH2487`)

This device tree is engineered for **universal compatibility** across all major AOSP and CAF-based custom ROMs (LineageOS, crDroid, PixelOS, Evolution X, RisingOS, Project Matrixx, DerpFest, SuperiorOS, etc.).

---

## 📱 Hardware & Firmware Specifications

| Feature | Specification |
|:---|:---|
| **Device Model** | OnePlus 11R 5G (India / Global) — `CPH2487` (Project ID: `22881`) |
| **Codename** | `udon` |
| **SoC** | Qualcomm Snapdragon 8+ Gen 1 (`SM8475`) |
| **Board / Platform** | `taro` / `waipio` (`sm8450-common` / `sm8475-common`) |
| **Architecture** | `arm64-v8a`, `armeabi-v7a` (Kryo 385 / Cortex-X2/A710/A510) |
| **Display** | 6.74" 1240 x 2772 pixels AMOLED, 120Hz, HDR10+, 450 PPI |
| **Fingerprint** | Optical Under-Display FOD (`POS_X=445`, `POS_Y=2200`, `SIZE=190`) |
| **Firmware Base** | Official OxygenOS `CPH2487_16.0.5.1002(EX01)` (Security Patch: `2026-07-01`) |
| **Stock Fingerprint** | `OnePlus/CPH2487/OP5961L1:16/BP2A.250605.015/T.R4T3.2e09920-970cae-a2101f:user/release-keys` |

---

## 🚀 Supported Custom ROMs & Lunch Commands

| Custom ROM | Lunch Command | Product Makefile |
|:---|:---|:---|
| **LineageOS** | `lunch lineage_udon-userdebug` | `lineage_udon.mk` |
| **crDroid** | `lunch crdroid_udon-userdebug` | `crdroid_udon.mk` |
| **PixelOS / PixelExperience** | `lunch aosp_udon-userdebug` | `aosp_udon.mk` |
| **Evolution X** | `lunch evolution_udon-userdebug` | `evolution_udon.mk` |
| **RisingOS** | `lunch rising_udon-userdebug` | `rising_udon.mk` |
| **Project Matrixx / DerpFest** | `lunch aosp_udon-userdebug` | `aosp_udon.mk` |
| **Generic AOSP / AOSP-Krypton** | `lunch aosp_udon-userdebug` | `aosp_udon.mk` |

---

## 🛠️ Step-by-Step Build Guide

### 1. Set Up Local Manifest
Add the local manifest so all required repositories (device tree, common tree, kernel, hardware HALs) are pulled automatically:

```bash
git clone https://github.com/Gokulgethu/local_manifests.git .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
```

### 2. Extract Proprietary Blobs
```bash
cd device/oneplus/udon
./extract-files.sh
```

### 3. Build Your Chosen ROM
```bash
# Setup environment
source build/envsetup.sh

# Select lunch target (example: LineageOS or crDroid)
lunch lineage_udon-userdebug
# or
lunch crdroid_udon-userdebug

# Start compilation
mka bacon -j$(nproc --all)
```

---

## 📂 Repository Contents

```
├── Android.bp
├── Android.mk
├── AndroidProducts.mk          # Unified lunch choices for all ROMs
├── BoardConfig.mk              # Chipset SM8475 / taro, display 450 DPI, FOD coords
├── BoardConfigCommon.mk        # Dynamic partitions, AVB 2.0, kernel definitions
├── BoardConfigVendor.mk
├── common.mk
├── lineage_udon.mk             # LineageOS product makefile
├── crdroid_udon.mk             # crDroid product makefile
├── evolution_udon.mk           # Evolution X product makefile
├── rising_udon.mk              # RisingOS product makefile
├── aosp_udon.mk                # Generic AOSP / PixelOS product makefile
├── lineage_CPH2487.mk          # CPH2487 model product makefile
├── vendorsetup.sh              # Lunch combos registration
├── lineage.dependencies        # Common tree and kernel dependencies
├── board-info.txt
├── config.fs
├── compatibility_matrix.xml
├── manifest.xml                # HAL definitions (Audio, Camera, Sensors, Fingerprint)
├── proprietary-files.txt       # Proprietary blob extraction list
├── extract-files.sh / setup-makefiles.sh
├── configs/audio/              # Audio policies, effects & mixer paths
├── init/                       # Stock fstab.qcom & fstab.default
└── overlay/                    # Framework and Bluetooth RRO overlays
```

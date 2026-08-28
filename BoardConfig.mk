#
# Copyright (C) 2023-2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/oneplus/CPH2487
DEVICE_UDON_PATH := device/oneplus/udon
BOARD_VENDOR := oneplus

# Build System Lenient Flags for Custom ROMs
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_BUILD_MODULES := true
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true
BUILD_BROKEN_INCORRECT_PARTITION_IMAGES := true

# Include the common OEM chipset BoardConfig (Snapdragon 8+ Gen 1 SM8475 / taro)
-include $(DEVICE_PATH)/BoardConfigCommon.mk
-include $(DEVICE_UDON_PATH)/BoardConfigCommon.mk
-include device/oneplus/sm8475-common/BoardConfigCommon.mk
-include device/oneplus/sm8450-common/BoardConfigCommon.mk

# Display
TARGET_SCREEN_DENSITY := 450

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 103

# Security patch level (OxygenOS latest build)
VENDOR_SECURITY_PATCH := 2026-07-01
BOOT_SECURITY_PATCH := 2026-07-01

# Fingerprint (Under-display optical FOD)
SOONG_CONFIG_NAMESPACES += ONEPLUS_FOD
SOONG_CONFIG_ONEPLUS_FOD += POS_X POS_Y SIZE
SOONG_CONFIG_ONEPLUS_FOD_POS_X := 445
SOONG_CONFIG_ONEPLUS_FOD_POS_Y := 2200
SOONG_CONFIG_ONEPLUS_FOD_SIZE := 190

# Touch HAL
SOONG_CONFIG_NAMESPACES += OPLUS_LINEAGE_TOUCH_HAL
SOONG_CONFIG_OPLUS_LINEAGE_TOUCH_HAL := INCLUDE_DIR
SOONG_CONFIG_OPLUS_LINEAGE_TOUCH_HAL_INCLUDE_DIR := $(DEVICE_PATH)/touch/include

# Matrix files
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/framework_compatibility_matrix.xml

# Inherit proprietary vendor BoardConfigs
-include vendor/oneplus/CPH2487/BoardConfigVendor.mk
-include vendor/oneplus/udon/BoardConfigVendor.mk
-include vendor/oneplus/sm8450-common/BoardConfigVendor.mk
-include vendor/oneplus/sm8475-common/BoardConfigVendor.mk

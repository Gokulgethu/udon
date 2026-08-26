# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
# SPDX-License-Identifier: Apache-2.0

LOCAL_PATH := device/oneplus/udon

# A/B Post-Instal Config
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/oplusotapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# A/B OTA Partitions   
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := abl aop aop_config bluetooth boot cpucp devcfg dsp dtbo engineering_cdt featenabler hyp imagefv keymaster modem my_bigball my_carrier my_colorospro my_company my_engineering my_heytap my_manifest my_preload my_product my_region my_stock odm odm_dlkm oplus_sec oplusstanvbk product qupfw recovery shrm splash system system_ext tz uefi uefisecapp vbmeta vbmeta_system vbmeta_vendor vendor vendor_boot vendor_dlkm xbl xbl_config xbl_ramdump
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

# Stock OEM OTA Cert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(LOCAL_PATH)/security/local_OTA \
    $(LOCAL_PATH)/security/special_OTA

# Update Engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# F2FS Utilities
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# OTA Script
PRODUCT_PACKAGES += \
    oplusotapreopt_script

# Userdata Checkpoint
PRODUCT_PACKAGES += \
    checkpoint_gc

# QCom Decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Fastboot/D
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service \
	android.system.keystore2

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# API/SDK Version
PRODUCT_TARGET_VNDK_VERSION := 31
PRODUCT_SHIPPING_API_LEVEL := 31
BOARD_SHIPPING_API_LEVEL := 31
SHIPPING_API_LEVEL := 31

# Support to compile recovery without msm headers
TARGET_HAS_GENERIC_KERNEL_HEADERS := true

# Enable Fuse Passthrough
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true

#namespace definition for librecovery_updater
#differentiate legacy 'sg' or 'bsg' framework
SOONG_CONFIG_NAMESPACES += ufsbsg
SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

# OTA Assert
TARGET_OTA_ASSERT_DEVICE := CPH2487,ossi,qssi

# Inherit some common sm8450 stuff.
#$(call inherit-product, device/oneplus/sm8450-common/common.mk)

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

# ---------------------------------------------------------------------------
# QCom decryption stack — prebuilt binaries from stock OxygenOS
# (CPH2487_16.0.5.700.EX01, Android 16, 2026-05) — copied into the TWRP
# ramdisk so FBE metadata decryption works on stock OOS15/16.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.qcom.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.usb.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.usb.rc \
    $(LOCAL_PATH)/recovery/root/ueventd.qcom.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.qcom.rc \
    $(LOCAL_PATH)/recovery/root/system/bin/android.hardware.gatekeeper@1.0-service-qti:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.gatekeeper@1.0-service-qti \
    $(LOCAL_PATH)/recovery/root/system/bin/android.hardware.keymaster@4.0-service-qti:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.keymaster@4.0-service-qti \
    $(LOCAL_PATH)/recovery/root/system/bin/android.hardware.keymaster@4.1-service-qti:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.keymaster@4.1-service-qti \
    $(LOCAL_PATH)/recovery/root/system/bin/android.hardware.security.keymint-service-qti:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.security.keymint-service-qti \
    $(LOCAL_PATH)/recovery/root/system/bin/qseecomd:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/qseecomd \
    $(LOCAL_PATH)/recovery/root/system/bin/vendor.qti.hardware.qteeconnector@1.0-service:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/vendor.qti.hardware.qteeconnector@1.0-service \
    $(LOCAL_PATH)/recovery/root/system/etc/event-log-tags:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/event-log-tags \
    $(LOCAL_PATH)/recovery/root/system/etc/fstab.postinstall:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/fstab.postinstall \
    $(LOCAL_PATH)/recovery/root/system/etc/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/recovery.fstab \
    $(LOCAL_PATH)/recovery/root/system/etc/task_profiles.json:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/task_profiles.json \
    $(LOCAL_PATH)/recovery/root/system/etc/twrp.flags:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/twrp.flags \
    $(LOCAL_PATH)/recovery/root/system/etc/ueventd.rc:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/ueventd.rc \
    $(LOCAL_PATH)/recovery/root/system/etc/vintf/manifest.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/manifest.xml \
    $(LOCAL_PATH)/recovery/root/vendor/ueventd.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/ueventd.rc \
    $(LOCAL_PATH)/recovery/root/vendor/etc/gpfspath_oem_config.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/gpfspath_oem_config.xml \
    $(LOCAL_PATH)/recovery/root/vendor/etc/task_profiles.json:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/task_profiles.json \
    $(LOCAL_PATH)/recovery/root/vendor/etc/init/android.hardware.security.keymint-service-qti.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/android.hardware.security.keymint-service-qti.rc \
    $(LOCAL_PATH)/recovery/root/vendor/etc/init/vendor.qti.hardware.qteeconnector@1.0-service.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/vendor.qti.hardware.qteeconnector@1.0-service.rc \
    $(LOCAL_PATH)/recovery/root/vendor/etc/vintf/manifest.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest.xml \
    $(LOCAL_PATH)/recovery/root/vendor/etc/vintf/manifest/android.hardware.security.keymint-service-qti.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest/android.hardware.security.keymint-service-qti.xml \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/adsp_loader_dlkm.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/adsp_loader_dlkm.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/gpr_dlkm.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/gpr_dlkm.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/q6_notifier_dlkm.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/q6_notifier_dlkm.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/q6_pdr_dlkm.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/q6_pdr_dlkm.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/snd_event_dlkm.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/snd_event_dlkm.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/spf_core_dlkm.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/spf_core_dlkm.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hardware.boot@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.boot@1.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hardware.boot@1.1.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.boot@1.1.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hardware.boot@1.2.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.boot@1.2.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hardware.gatekeeper@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.gatekeeper@1.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hardware.keymaster@3.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.keymaster@3.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hardware.keymaster@4.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.keymaster@4.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hardware.keymaster@4.1.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.keymaster@4.1.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hardware.secure_element@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.secure_element@1.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hardware.security.keymint-V1-ndk_platform.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.security.keymint-V1-ndk_platform.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hardware.security.secureclock-V1-ndk_platform.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.security.secureclock-V1-ndk_platform.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hardware.security.sharedsecret-V1-ndk_platform.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.security.sharedsecret-V1-ndk_platform.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hidl.allocator@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hidl.allocator@1.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hidl.memory.token@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hidl.memory.token@1.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/android.hidl.memory@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hidl.memory@1.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/ld-android.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/ld-android.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libGPreqcancel.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libGPreqcancel.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libGPreqcancel_svc.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libGPreqcancel_svc.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libQSEEComAPI.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libQSEEComAPI.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libandroid_runtime_lazy.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libandroid_runtime_lazy.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libandroidicu.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libbase.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libbase.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libbinder.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libbinder.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libbinder_ndk.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libbinder_ndk.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libboot_control_qti.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libboot_control_qti.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libc++.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libc++.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libc.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libc.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libcrypto.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libcrypto.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libcutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libcutils.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdiag.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libdiag.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdisplayconfig.qti.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libdisplayconfig.qti.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdisplaydebug.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libdisplaydebug.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdl.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libdl.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdl_android.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libdl_android.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdmabufheap.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libdmabufheap.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdrm.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libdrm.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdrmfs.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libdrmfs.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdrmtime.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libdrmtime.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdrmutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libdrmutils.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libdsutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libdsutils.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libhardware.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libhardware.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libhidlbase.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libhidlbase.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libhidlmemory.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libhidlmemory.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libicui18n.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libicui18n.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libicuuc.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libicuuc.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libidl.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libidl.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libion.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libion.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libkeymaster_messages.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libkeymaster_messages.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libkeymasterdeviceutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libkeymasterdeviceutils.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libkeymasterutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libkeymasterutils.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/liblog.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/liblog.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libm.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libm.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libmdmdetect.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libmdmdetect.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libminkdescriptor.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libminkdescriptor.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libminksocket_vendor.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libminksocket_vendor.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libnetutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libnetutils.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libops.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libops.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqcbor.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libqcbor.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqdutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libqdutils.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqisl.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libqisl.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_cci.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libqmi_cci.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_client_qmux.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libqmi_client_qmux.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmi_encdec.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libqmi_encdec.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqmiservices.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libqmiservices.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqrtr.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libqrtr.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqservice.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libqservice.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqtikeymaster4.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libqtikeymaster4.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libqtikeymint.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libqtikeymint.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/librecovery_updater.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/librecovery_updater.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/librecovery_updater_msm.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/librecovery_updater_msm.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/librpmb.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/librpmb.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libsecureui_svcsock.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libsecureui_svcsock.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libsoc_helper.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libsoc_helper.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libsoc_helper_jni.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libsoc_helper_jni.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libspcom.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libspcom.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libspl.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libspl.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libssd.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libssd.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libthermalclient.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libthermalclient.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libtime_genoff.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libtime_genoff.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libutils.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libutils.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libvmmem.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libvmmem.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libvndksupport.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libvndksupport.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/libxml2.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libxml2.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/vendor.display.config@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/vendor.display.config@1.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/vendor.display.config@2.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/vendor.display.config@2.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/vendor.qti.hardware.qteeconnector@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/vendor.qti.hardware.qteeconnector@1.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/vendor.qti.hardware.tui_comm@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/vendor.qti.hardware.tui_comm@1.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/vendor.qti.hardware.wifi.keystore@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/vendor.qti.hardware.wifi.keystore@1.0.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/hw/android.hardware.boot@1.0-impl-1.2-qti.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/android.hardware.boot@1.0-impl-1.2-qti.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl-qti.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl-qti.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/hw/android.hardware.health@2.0-impl-2.1-qti.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/android.hardware.health@2.0-impl-2.1-qti.so \
    $(LOCAL_PATH)/recovery/root/vendor/lib64/hw/vendor.qti.hardware.qteeconnector@1.0-impl.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/vendor.qti.hardware.qteeconnector@1.0-impl.so

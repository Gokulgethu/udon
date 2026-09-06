#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Product Information
PRODUCT_DEVICE := udon
PRODUCT_RELEASE_NAME := $(PRODUCT_DEVICE)
PRODUCT_NAME := twrp_$(PRODUCT_DEVICE)
PRODUCT_BRAND := oneplus
PRODUCT_MODEL := CPH2487
PRODUCT_PLATFORM := taro
PRODUCT_MANUFACTURER := oneplus

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit some common Twrp stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from udon device
$(call inherit-product, device/oneplus/udon/device.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="OnePlus/twrp_udon/udon:16.1.0/SP2A.220405.004/zen:eng/test-keys" \
    TARGET_DEVICE=$(PRODUCT_SYSTEM_DEVICE) \
    TARGET_PRODUCT=$(PRODUCT_SYSTEM_NAME)

BUILD_FINGERPRINT := OnePlus/twrp_udon/udon:16.1.0/SP2A.220405.004/zen:eng/test-keys

# Virtual A/B OTA
ENABLE_VIRTUAL_AB := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
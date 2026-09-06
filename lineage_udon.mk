#
# Copyright (C) 2023-2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from udon / CPH2487 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := OnePlus
PRODUCT_DEVICE := udon
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_NAME := lineage_udon
PRODUCT_MODEL := CPH2487

PRODUCT_GMS_CLIENTID_BASE := android-oneplus
TARGET_VENDOR := oneplus
TARGET_VENDOR_PRODUCT_NAME := udon
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="CPH2487-user 16 BP2A.250605.015 T.R4T3.2e09920 release-keys"

# Exact build fingerprint from official OxygenOS firmware
BUILD_FINGERPRINT := OnePlus/CPH2487/OP5961L1:16/BP2A.250605.015/T.R4T3.2e09920-970cae-a2101f:user/release-keys

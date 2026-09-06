#
# Copyright (C) 2023-2026 Project Matrixx
#
# SPDX-License-Identifier: Apache-2.0
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

$(call inherit-product-if-exists, vendor/matrixx/config/common.mk)
$(call inherit-product-if-exists, vendor/lineage/config/common_full_phone.mk)

$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := OnePlus
PRODUCT_DEVICE := udon
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_NAME := matrixx_udon
PRODUCT_MODEL := CPH2487

PRODUCT_GMS_CLIENTID_BASE := android-oneplus
TARGET_VENDOR := oneplus
TARGET_VENDOR_PRODUCT_NAME := udon

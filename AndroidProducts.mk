#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_udon.mk

COMMON_LUNCH_CHOICES := \
    twrp_udon-ap2a-user \
    twrp_udon-ap2a-userdebug \
    twrp_udon-ap2a-eng

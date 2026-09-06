#
# Copyright (C) 2023-2026 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/lineage_udon.mk \
    $(LOCAL_DIR)/lineage_CPH2487.mk \
    $(LOCAL_DIR)/aosp_udon.mk \
    $(LOCAL_DIR)/crdroid_udon.mk \
    $(LOCAL_DIR)/evolution_udon.mk \
    $(LOCAL_DIR)/rising_udon.mk \
    $(LOCAL_DIR)/pixelos_udon.mk \
    $(LOCAL_DIR)/matrixx_udon.mk \
    $(LOCAL_DIR)/derp_udon.mk \
    $(LOCAL_DIR)/bliss_udon.mk

COMMON_LUNCH_CHOICES := \
    lineage_udon-user \
    lineage_udon-userdebug \
    lineage_udon-eng \
    lineage_CPH2487-user \
    lineage_CPH2487-userdebug \
    lineage_CPH2487-eng \
    aosp_udon-userdebug \
    crdroid_udon-userdebug \
    evolution_udon-userdebug \
    rising_udon-userdebug \
    pixelos_udon-userdebug \
    matrixx_udon-userdebug \
    derp_udon-userdebug \
    bliss_udon-userdebug

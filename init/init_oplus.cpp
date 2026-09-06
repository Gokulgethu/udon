/*
 * Copyright (C) 2023-2026 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <android-base/logging.h>
#include <android-base/properties.h>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

using android::base::GetProperty;

void property_override(char const prop[], char const value[], bool add = true) {
    prop_info *pi = (prop_info *)__system_property_find(prop);
    if (pi) {
        __system_property_update(pi, value, strlen(value));
    } else if (add) {
        __system_property_add(prop, strlen(prop), value, strlen(value));
    }
}

void set_ro_build_prop(const std::string &prop, const std::string &value, bool build_desc = true) {
    for (const auto &source : {"", "bootimage.", "odm.", "product.", "system.", "system_ext.", "vendor.", "vendor_dlkm."}) {
        auto prop_name = "ro." + std::string(source) + "build." + prop;
        property_override(prop_name.c_str(), value.c_str(), false);
    }

    if (build_desc) {
        auto prop_name = "ro.build." + prop;
        property_override(prop_name.c_str(), value.c_str(), false);
    }
}

void set_device_props(const std::string &brand, const std::string &device, const std::string &model,
                      const std::string &name, const std::string &marketname) {
    for (const auto &source : {"", "bootimage.", "odm.", "product.", "system.", "system_ext.", "vendor.", "vendor_dlkm."}) {
        auto prop_name = "ro.product." + std::string(source) + "brand";
        property_override(prop_name.c_str(), brand.c_str(), false);
        prop_name = "ro.product." + std::string(source) + "device";
        property_override(prop_name.c_str(), device.c_str(), false);
        prop_name = "ro.product." + std::string(source) + "model";
        property_override(prop_name.c_str(), model.c_str(), false);
        prop_name = "ro.product." + std::string(source) + "name";
        property_override(prop_name.c_str(), name.c_str(), false);
    }
    property_override("ro.oplus.market.name", marketname.c_str(), false);
    property_override("ro.vendor.oplus.market.name", marketname.c_str(), false);
}

void vendor_load_properties() {
    std::string prjname = GetProperty("ro.boot.prjname", "22881");
    std::string sku = GetProperty("ro.boot.hardware.sku", "CPH2487");

    // OnePlus 11R 5G (CPH2487 / udon / 22881)
    set_device_props("OnePlus", "OP5961L1", "CPH2487", "CPH2487", "OnePlus 11R 5G");
    set_ro_build_prop("fingerprint", "OnePlus/CPH2487/OP5961L1:16/BP2A.250605.015/T.R4T3.2e09920-970cae-a2101f:user/release-keys");
    set_ro_build_prop("description", "CPH2487-user 16 BP2A.250605.015 T.R4T3.2e09920 release-keys");
}

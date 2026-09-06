# Bring-up and build status

## Snapshot

Created for OnePlus 11R 5G India/Global, model CPH2487, codename commonly called `udon`, SoC SM8475 and Qualcomm platform/board `taro`.

The four source repositories are included as shallow checkouts. Their original Git history, licenses and upstream files are retained. The root README and manifest are integration additions.

## Expected external dependencies

The checked-in device files reference these paths or classes that must exist in the selected ROM source tree:

- `device/oneplus/sm8350-common`
- `hardware/qcom-caf/common`
- `device/qcom/sepolicy_vndr`
- `vendor/lineage`
- `kernel/oneplus/sm8350` or a deliberately adapted matching kernel path

Resolve these references for the ROM branch before compiling. A source tree can parse successfully and still fail to boot if the kernel, modules, DTBO, firmware and proprietary HAL versions do not match.

## Required bring-up checks

1. Confirm `ro.product.vendor.model` and bootloader properties identify CPH2487, not PHK110 or another OnePlus model.
2. Use firmware from the same Android/OxygenOS generation as the ROM base. Keep `boot`, `vendor_boot`, `dtbo`, `vbmeta*`, firmware and super-partition contents from a compatible release.
3. Extract all proprietary files from that exact CPH2487 build and run the ROM's vendor-file generation script.
4. Reconcile the common-tree path and kernel source/config. The included common BoardConfig currently points to `kernel/oneplus/sm8350` and `vendor/taro-qgki_defconfig`; this must be checked against the kernel source actually synced.
5. Validate partition sizes, AVB keys/flags, dynamic-partition group size and boot header settings against the target ROM branch and device dumps. The test AVB keys in a development tree are not production signing keys.
6. Build recovery/boot first, test with temporary fastboot boot where supported, then test the full image set. Do not relock the bootloader.

## Functional test checklist

- boot and recovery / decryption
- display, touch, brightness and refresh rate
- Wi-Fi, Bluetooth, GPS, NFC and USB
- SIM, calls, mobile data, VoLTE/IMS and SMS
- cameras, flashlight and video encoding
- fingerprint, face unlock, vibration and sensors
- audio speaker, microphone, wired/USB audio and Bluetooth audio
- charging, battery stats, suspend/resume and thermal limits
- SELinux enforcing, AVB and OTA/A-B update behavior

This file intentionally does not claim that the snapshot is production-ready: proprietary blobs and hardware validation cannot be generated safely without the target firmware and a test device.

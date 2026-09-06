#!/usr/bin/env bash
#
# Yazhu Kernel Build Script for OnePlus 11R 5G (udon / aston / CPH2487)
#

set -e

DEVICE="udon"
ARCH="arm64"
SUBARCH="arm64"
ROOT_DIR="$(pwd)"
OUT_DIR="${ROOT_DIR}/out"

echo "=== OnePlus 11R (${DEVICE}) Kernel Builder ==="

if [ -z "${CLANG_PATH}" ]; then
    if [ -d "$HOME/clang/bin" ]; then
        export PATH="$HOME/clang/bin:$PATH"
    fi
fi

echo "Compiler version: $(clang --version | head -1)"

echo "--> Configuring kernel (gki_defconfig + waipio/oplus fragments)..."
make O="${OUT_DIR}" ARCH="${ARCH}" LLVM=1 gki_defconfig
FRAGS="arch/arm64/configs/vendor/waipio_GKI.config \
       arch/arm64/configs/vendor/oplus_GKI.config \
       arch/arm64/configs/vendor/debugfs.config"

./scripts/kconfig/merge_config.sh -m -O "${OUT_DIR}" "${OUT_DIR}/.config" ${FRAGS}
make O="${OUT_DIR}" ARCH="${ARCH}" LLVM=1 olddefconfig

echo "--> Compiling Kernel Image..."
make -j"$(nproc)" O="${OUT_DIR}" ARCH="${ARCH}" LLVM=1 LLVM_IAS=1 Image

echo "--> Kernel Image compiled successfully: ${OUT_DIR}/arch/arm64/boot/Image"

#!/usr/bin/env bash
#### RetroMi Packages — Build a group of emulator cores inside Debian Bookworm
# Runs inside: docker run --platform linux/arm/v7|linux/arm64 debian:bookworm
# Usage: build-group.sh <group>
# Env:   ARCH=armhf|arm64  (injected by docker run -e)

set -Ee

GROUP="${1:?Usage: $0 <group>}"
ARCH="${ARCH:-armhf}"
PACKAGES_FILE="/groups/${GROUP}.txt"
OUTPUT_DIR="/output"

if [[ ! -f "${PACKAGES_FILE}" ]]; then
    echo "ERROR: Group file not found: ${PACKAGES_FILE}"
    exit 1
fi

mkdir -p "${OUTPUT_DIR}"

echo "================================================================"
echo " RetroMi-packages | group: ${GROUP} | arch: $(uname -m) [${ARCH}]"
echo "================================================================"

# Base system dependencies needed by RetroPie build scripts
apt-get update -qq
apt-get install -y --no-install-recommends \
    git curl wget ca-certificates sudo dialog \
    build-essential cmake pkg-config \
    libsdl2-dev libsdl2-gfx-1.0-0 libsdl2-mixer-2.0-0 \
    libsdl2-net-2.0-0 libsdl2-ttf-2.0-0 libsdl2-image-2.0-0 \
    libusb-1.0-0-dev libavformat-dev libavdevice-dev \
    xmlstarlet joystick python3

# RetroPie scripts expect a 'pi' user
id -u pi &>/dev/null || useradd -m -s /bin/bash pi
echo "pi ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Clone Yumi-Lab/RetroPie-Setup yumi-armhf branch (official fork — armhf/Mali-400 custom patches)
echo ""
echo "=== Cloning Yumi-Lab/RetroPie-Setup (yumi-armhf branch) ==="
git clone --depth=1 -b yumi-armhf \
    https://github.com/Yumi-Lab/RetroPie-Setup.git \
    /home/pi/RetroPie-Setup
chown -R pi:pi /home/pi/RetroPie-Setup

# Patch mali flags for retroarch group (Lima/Armbian uses EGL/KMS, not mali fbdev)
if [[ "${GROUP}" == "retroarch" ]]; then
    echo "=== Patching mali fbdev flags for Lima/Armbian ==="

    # Dummy mali-fbdev package (satisfies apt dep check, no actual driver)
    apt-get install -y equivs -qq
    cat > /tmp/mali-fbdev-dummy.ctrl << 'EQUIVS_CTRL'
Section: misc
Priority: optional
Standards-Version: 3.9.2

Package: mali-fbdev
Version: 1.0-retromi
Maintainer: RetroMi <build@yumi-lab.com>
Description: Dummy mali-fbdev for Armbian/Lima builds
EQUIVS_CTRL
    mkdir -p /tmp/mali-fbdev-build && cp /tmp/mali-fbdev-dummy.ctrl /tmp/mali-fbdev-build/
    cd /tmp/mali-fbdev-build && equivs-build mali-fbdev-dummy.ctrl
    dpkg -i /tmp/mali-fbdev-build/mali-fbdev_1.0-retromi_all.deb
    cd /home/pi/RetroPie-Setup

    # Remove mali video backend from SDL2 (uses fbdev driver absent on Lima)
    sed -i '/enable-video-mali/d' \
        /home/pi/RetroPie-Setup/scriptmodules/supplementary/sdl2.sh
    # Remove mali_fbdev from RetroArch configure
    sed -i '/enable-mali_fbdev/d' \
        /home/pi/RetroPie-Setup/scriptmodules/emulators/retroarch.sh
fi

# Force platform for QEMU builds (prevents -march=native on x86 host)
if [[ "${ARCH}" == "armhf" ]]; then
    export __platform="armv7-mali"
elif [[ "${ARCH}" == "arm64" ]]; then
    export __platform="aarch64"
fi

# Install each package listed in the group file
cd /home/pi/RetroPie-Setup

FAILED_PKGS=()

while IFS= read -r pkg; do
    # Skip empty lines and comments
    [[ -z "${pkg}" || "${pkg}" == \#* ]] && continue

    echo ""
    echo "================================================================"
    echo " Installing: ${pkg}"
    echo "================================================================"

    # Run as root but tell RetroPie to install for user 'pi' via __user
    if ! __user=pi bash retropie_packages.sh "${pkg}"; then
        echo "WARNING: ${pkg} installation failed, continuing..."
        FAILED_PKGS+=("${pkg}")
    fi

done < "${PACKAGES_FILE}"

# Report any failures
if [[ ${#FAILED_PKGS[@]} -gt 0 ]]; then
    echo ""
    echo "WARNING: The following packages failed:"
    for p in "${FAILED_PKGS[@]}"; do
        echo "  - ${p}"
    done
fi

# Package /opt/retropie for this group
echo ""
echo "=== Packaging /opt/retropie ==="

if [[ ! -d /opt/retropie ]]; then
    echo "ERROR: /opt/retropie does not exist after installation"
    exit 1
fi

tar -czf "${OUTPUT_DIR}/packages-${GROUP}-${ARCH}.tar.gz" -C / opt/retropie/

echo "Created: ${OUTPUT_DIR}/packages-${GROUP}-${ARCH}.tar.gz"
ls -lh "${OUTPUT_DIR}/"

echo ""
echo "=== Done: group ${GROUP} | arch: ${ARCH} ==="


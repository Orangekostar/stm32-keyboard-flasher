#!/bin/bash
set -e

echo "============================================"
echo "  STM32F103 Keyboard - Udev Rule Installer"
echo "  Maple 003 Bootloader (1EAF:0003)"
echo "============================================"
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RULES_FILE="$SCRIPT_DIR/99-maple003.rules"
TARGET="/etc/udev/rules.d/99-maple003.rules"

if [ ! -f "$RULES_FILE" ]; then
    echo "[ERROR] Cannot find 99-maple003.rules in: $SCRIPT_DIR"
    echo "Please run this script from the drivers/linux/ directory."
    exit 1
fi

echo "[STEP 1/3] Installing udev rules..."
sudo cp "$RULES_FILE" "$TARGET"
echo "[OK] Rules installed to $TARGET"

echo ""
echo "[STEP 2/3] Reloading udev rules..."
sudo udevadm control --reload-rules
echo "[OK] Rules reloaded"

echo ""
echo "[STEP 3/3] Triggering udev..."
sudo udevadm trigger
echo "[OK] Triggered"

echo ""
echo "============================================"
echo "  Installation complete!"
echo "============================================"
echo ""
echo "Unplug and replug your keyboard (hold ESC for DFU mode),"
echo "then open index.html in Chrome/Edge to flash firmware."
echo ""

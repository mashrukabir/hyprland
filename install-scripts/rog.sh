#!/bin/bash
# Asus ROG Laptops #

# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_rog.log"

### Install software for Asus ROG laptops ###

printf " Installing ASUS ROG packages...\n"
for ASUS in asusctl supergfxctl rog-control-center; do
install_package  "$ASUS" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
  echo -e "\e[1A\e[K${ERROR} - $ASUS install had failed, please check the install.log"
  exit 1
  fi
done

printf " Enabling ROG services...\n"
sudo systemctl enable --now supergfxd 2>&1 | tee -a "$LOG"

clear


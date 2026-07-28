#!/usr/bin/env bash
# Upgrade all installed packages (includes BlackArch tools)

set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; RESET='\033[0m'

[[ $EUID -ne 0 ]] && echo -e "\033[0;31m[!] Run as root\033[0m" && exit 1

echo -e "${CYAN}[*] Syncing and upgrading all packages...${RESET}"
pacman -Syu --noconfirm

echo -e "${GREEN}[+] Done.${RESET}"

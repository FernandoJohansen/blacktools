#!/usr/bin/env bash
# Upgrade all installed BlackArch tools

set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; RESET='\033[0m'

[[ $EUID -ne 0 ]] && echo -e "\033[0;31m[!] Run as root\033[0m" && exit 1

echo -e "${CYAN}[*] Syncing BlackArch mirrors...${RESET}"
pacman -Sy

echo -e "${CYAN}[*] Upgrading all installed BlackArch packages...${RESET}"
pacman -Su --noconfirm $(pacman -Qq | grep -E '^(blackarch|openvas|metasploit|sqlmap|nmap|nikto|hydra|john|hashcat|aircrack|wireshark|burpsuite|gobuster|ffuf|amass|subfinder|nuclei|masscan|feroxbuster|wfuzz|dirsearch|crackmapexec|impacket|responder|bloodhound|neo4j|evil-winrm|nxc)' 2>/dev/null | tr '\n' ' ') 2>/dev/null || true

echo -e "${GREEN}[+] Done.${RESET}"

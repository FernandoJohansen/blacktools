#!/usr/bin/env bash
# blacktools installer — select categories to install via pacman

set -euo pipefail

RED='\033[0;31m'; YELLOW='\033[1;33m'; GREEN='\033[0;32m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

die()  { echo -e "${RED}[!] $*${RESET}" >&2; exit 1; }
info() { echo -e "${CYAN}[*] $*${RESET}"; }
ok()   { echo -e "${GREEN}[+] $*${RESET}"; }
warn() { echo -e "${YELLOW}[!] $*${RESET}"; }

[[ $EUID -ne 0 ]] && die "Run as root: sudo bash install.sh"

# ── category definitions ────────────────────────────────────────────────────
declare -A CAT_LABEL=(
  [recon]="Recon / OSINT / Scanning"
  [web]="Web & Webapp"
  [exploitation]="Exploitation & Backdoors"
  [passwords]="Passwords & Crypto"
  [wireless]="Wireless / Bluetooth / RF"
  [networking]="Networking / Tunneling / VoIP"
  [reversing]="Reverse Engineering"
  [forensics]="Forensics & Malware Analysis"
  [social]="Social Engineering & Mobile"
  [misc]="Misc / Automation / Hardware"
)

# categories in display order
CATS=(recon web exploitation passwords wireless networking reversing forensics social misc)

pkg_count() {
  local total=0
  while IFS= read -r group; do
    [[ -z "$group" || "$group" == \#* ]] && continue
    n=$(pacman -Sg "$group" 2>/dev/null | wc -l)
    total=$((total + n))
  done < "$SCRIPT_DIR/$1/groups.txt"
  echo "$total"
}

print_banner() {
  echo -e "${BOLD}"
  echo "  ██████╗ ██╗      █████╗  ██████╗██╗  ██╗████████╗ ██████╗  ██████╗ ██╗     ███████╗"
  echo "  ██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝"
  echo "  ██████╔╝██║     ███████║██║     █████╔╝    ██║   ██║   ██║██║   ██║██║     ███████╗"
  echo "  ██╔══██╗██║     ██╔══██║██║     ██╔═██╗    ██║   ██║   ██║██║   ██║██║     ╚════██║"
  echo "  ██████╔╝███████╗██║  ██║╚██████╗██║  ██╗   ██║   ╚██████╔╝╚██████╔╝███████╗███████║"
  echo "  ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝"
  echo -e "${RESET}"
  echo -e "  BlackArch tool installer  |  $(date '+%Y-%m-%d')\n"
}

print_menu() {
  local selected=("$@")
  echo -e "${BOLD}  Select categories  [space = toggle, a = all, n = none, enter = install]${RESET}\n"
  local i=1
  for cat in "${CATS[@]}"; do
    local count
    count=$(pkg_count "$cat")
    local mark="  "
    for s in "${selected[@]}"; do
      [[ "$s" == "$cat" ]] && mark="${GREEN}✔ ${RESET}" && break
    done
    printf "  %b%2d)%b %b%-12s%b  %-38s  %b(%d pkgs)%b\n" \
      "${BOLD}" "$i" "${RESET}" \
      "${CYAN}" "$cat" "${RESET}" \
      "${CAT_LABEL[$cat]}" \
      "${YELLOW}" "$count" "${RESET}"
    ((i++))
  done
  echo ""
}

contains() { local e; for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done; return 1; }

interactive_menu() {
  local selected=()
  while true; do
    clear
    print_banner
    print_menu "${selected[@]}"
    echo -ne "  ${BOLD}Choice:${RESET} "
    read -r choice
    case "$choice" in
      a|A) selected=("${CATS[@]}") ;;
      n|N) selected=() ;;
      ""  )
        if [[ ${#selected[@]} -eq 0 ]]; then
          warn "Nothing selected. Pick at least one category."
          sleep 1
        else
          break
        fi
        ;;
      *)
        # accept numbers, space-separated or comma-separated
        IFS=', ' read -ra tokens <<< "$choice"
        for tok in "${tokens[@]}"; do
          if [[ "$tok" =~ ^[0-9]+$ ]]; then
            local idx=$((tok - 1))
            if [[ $idx -ge 0 && $idx -lt ${#CATS[@]} ]]; then
              local cat="${CATS[$idx]}"
              if contains "$cat" "${selected[@]}"; then
                selected=("${selected[@]/$cat}")
                # compact array
                local tmp=(); for s in "${selected[@]}"; do [[ -n "$s" ]] && tmp+=("$s"); done
                selected=("${tmp[@]}")
              else
                selected+=("$cat")
              fi
            fi
          fi
        done
        ;;
    esac
  done
  echo "${selected[@]}"
}

install_category() {
  local cat="$1"
  local groups=()
  while IFS= read -r group; do
    [[ -z "$group" || "$group" == \#* ]] && continue
    groups+=("$group")
  done < "$SCRIPT_DIR/$cat/groups.txt"

  info "Installing: ${CAT_LABEL[$cat]}"
  for g in "${groups[@]}"; do
    info "  group: $g"
    pacman -S --needed --noconfirm "$g" 2>&1 | grep -v "^$" | sed 's/^/    /'
  done
  ok "Done: $cat"
}

# ── dry-run / direct args ───────────────────────────────────────────────────
DRY_RUN=false
DIRECT_CATS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run|-d) DRY_RUN=true ;;
    --all|-a)     DIRECT_CATS=("${CATS[@]}") ;;
    --*)          die "Unknown flag: $1" ;;
    *)            DIRECT_CATS+=("$1") ;;
  esac
  shift
done

# ── main ────────────────────────────────────────────────────────────────────
print_banner

if [[ ${#DIRECT_CATS[@]} -gt 0 ]]; then
  TO_INSTALL=("${DIRECT_CATS[@]}")
else
  mapfile -t TO_INSTALL < <(interactive_menu | tr ' ' '\n' | grep -v '^$')
fi

echo ""
echo -e "${BOLD}  Will install:${RESET}"
for cat in "${TO_INSTALL[@]}"; do
  printf "    %-14s  %s\n" "$cat" "${CAT_LABEL[$cat]}"
done
echo ""

if $DRY_RUN; then
  warn "Dry run — no packages installed."
  exit 0
fi

echo -ne "${BOLD}  Proceed? [y/N] ${RESET}"
read -r confirm
[[ "$confirm" =~ ^[Yy]$ ]] || { warn "Aborted."; exit 0; }

echo ""
for cat in "${TO_INSTALL[@]}"; do
  install_category "$cat"
done

echo ""
ok "All done. Run './update.sh' anytime to upgrade installed tools."

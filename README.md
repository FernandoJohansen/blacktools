# blacktools

BlackArch tool collection — organized by category, installable by group.

## Structure

```
blacktools/
├── install.sh          ← start here
├── update.sh           ← upgrade installed tools
├── bin/                ← custom helper scripts (add to PATH)
│
├── recon/              Recon · OSINT · Scanning · Fingerprinting
├── web/                Web apps · Fuzzing · Proxies
├── exploitation/       Exploitation · Backdoors · C2 · AD attacks
├── passwords/          Password cracking · Crypto · Wordlists
├── wireless/           WiFi · Bluetooth · NFC · SDR/RF
├── networking/         Networking · MITM · Sniffing · Tunneling · VoIP
├── reversing/          Reverse engineering · Disasm · Debugging · Pwn
├── forensics/          Forensics · Memory · Malware · Steganography
├── social/             Social engineering · Phishing · Android/iOS
└── misc/               Automation · Hardware · Firmware · IDS · Honeypots
```

Each category folder has:
- `README.md` — key tools, quick-start commands, typical workflows
- `groups.txt` — the BlackArch pacman groups it installs

## Install

```bash
sudo bash install.sh               # interactive menu
sudo bash install.sh recon web     # install specific categories
sudo bash install.sh --all         # install everything (huge)
sudo bash install.sh --dry-run     # preview without installing
```

## Add bin/ to PATH

```bash
echo 'export PATH="$HOME/blacktools/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Update installed tools

```bash
sudo bash update.sh
```

# Misc / Automation / Hardware / IDS / Honeypots

**Groups:** `blackarch-automation` · `blackarch-hardware` · `blackarch-firmware` · `blackarch-drone` · `blackarch-dos` · `blackarch-honeypot` · `blackarch-ids` · `blackarch-misc`

---

## Key Tools

| Tool | What it does | Quick start |
|------|-------------|-------------|
| `burp-suite-pro` | Web proxy (pro if licensed) | `burpsuite` |
| `openvas` / `gvm` | Vulnerability scanner | `gvm-setup && gvm-start` |
| `nessus` | Vuln scanner (commercial) | `systemctl start nessusd` |
| `lynis` | System/server security audit | `lynis audit system` |
| `beef-xss` | Browser exploitation framework | `beef` |
| `snort` | IDS/IPS | `snort -A console -c /etc/snort/snort.conf` |
| `suricata` | IDS/IPS/NSM | `suricata -c /etc/suricata/suricata.yaml -i eth0` |
| `honeyd` | Honeypot daemon | `honeyd -f honeyd.conf` |
| `opencanary` | Modular honeypot | `opencanaryd --start` |
| `firmwalker` | Firmware secret finder | `firmwalker /path/to/extracted/fw/` |
| `binwalk` | Firmware extraction | `binwalk -e firmware.bin` |
| `flashrom` | Flash chip read/write | `flashrom -p linux_spi:dev=/dev/spidev0.0` |
| `avrdude` | AVR microcontroller programmer | `avrdude -p atmega328p -c arduino` |
| `minicom` | Serial terminal | `minicom -D /dev/ttyUSB0 -b 115200` |
| `openocd` | On-chip debugger (JTAG/SWD) | `openocd -f interface/jlink.cfg` |
| `fluxion` | WPA evil-twin automated | `fluxion` |

## Automation Scripts → `bin/`

Put your custom scripts in `../bin/` and add to PATH:

```bash
echo 'export PATH="$HOME/blacktools/bin:$PATH"' >> ~/.bashrc
```

## Firmware Analysis Flow

```bash
# 1. Extract
binwalk -e firmware.bin

# 2. Walk for secrets
firmwalker ./_firmware.bin.extracted/

# 3. Emulate (if MIPS/ARM)
# use QEMU with appropriate arch
```

## System Hardening Audit

```bash
lynis audit system --quick
# check /var/log/lynis-report.dat for findings
```

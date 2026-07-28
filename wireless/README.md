# Wireless / Bluetooth / RF

**Groups:** `blackarch-wireless` · `blackarch-bluetooth` · `blackarch-nfc` · `blackarch-radio`

---

## Key Tools

| Tool | What it does | Quick start |
|------|-------------|-------------|
| `aircrack-ng` | WEP/WPA cracking suite | `aircrack-ng -w wordlist.txt capture.cap` |
| `airodump-ng` | Capture 802.11 frames | `airodump-ng wlan0mon` |
| `aireplay-ng` | Inject frames / deauth | `aireplay-ng -0 5 -a <bssid> wlan0mon` |
| `wifite` | Automated WiFi auditor | `wifite` |
| `hcxdumptool` | Capture PMKIDs/handshakes | `hcxdumptool -i wlan0 -o dump.pcapng` |
| `hcxtools` | Convert captures for hashcat | `hcxpcapngtool dump.pcapng -o hash.hc22000` |
| `kismet` | Wireless network detector/IDS | `kismet` |
| `hostapd-wpe` | Rogue AP / EAP attacks | `hostapd-wpe hostapd-wpe.conf` |
| `eaphammer` | WPA2-Enterprise attacks | `eaphammer -i wlan0 --channel 1 --auth wpa-eap --essid Corp` |
| `bettercap` | MITM + wireless attacks | `bettercap -iface wlan0` |
| `mdk4` | 802.11 attack tool | `mdk4 wlan0mon d -b blacklist.txt` |
| `bluez` | Bluetooth stack tools | `bluetoothctl` |
| `blueranger` | Bluetooth proximity | `blueranger.py` |
| `btscanner` | Bluetooth scanner | `btscanner` |
| `gnuradio` | Software-defined radio | `gnuradio-companion` |
| `gqrx` | SDR receiver | `gqrx` |

## Typical WiFi Audit Flow

```bash
# 1. Enable monitor mode
ip link set wlan0 down
iw dev wlan0 set type monitor
ip link set wlan0 up
# or: airmon-ng start wlan0

# 2. Discover networks
airodump-ng wlan0mon

# 3. Capture handshake for a target
airodump-ng -c <ch> --bssid <bssid> -w capture wlan0mon
# in another terminal, deauth a client:
aireplay-ng -0 5 -a <bssid> -c <client_mac> wlan0mon

# 4. Crack
hcxpcapngtool capture-01.cap -o hash.hc22000
hashcat -m 22000 hash.hc22000 /usr/share/wordlists/rockyou.txt
```

## Notes

- Check adapter supports monitor mode: `iw list | grep "monitor"`
- Some cards need `airmon-ng check kill` to stop interfering processes

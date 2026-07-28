# Recon / OSINT / Scanning

**Groups:** `blackarch-recon` · `blackarch-scanner` · `blackarch-fingerprint`

---

## Key Tools

| Tool | What it does | Quick start |
|------|-------------|-------------|
| `nmap` | Port scan, service/OS detection | `nmap -sV -sC -p- <ip>` |
| `masscan` | Fastest internet-wide port scanner | `masscan -p0-65535 <ip> --rate=10000` |
| `amass` | Subdomain enumeration & OSINT | `amass enum -d example.com` |
| `subfinder` | Passive subdomain discovery | `subfinder -d example.com -o subs.txt` |
| `theHarvester` | Emails, IPs, hostnames from public sources | `theHarvester -d example.com -b all` |
| `shodan` | CLI for Shodan API | `shodan search 'apache country:"BR"'` |
| `recon-ng` | Web recon framework with modules | `recon-ng` then `marketplace search` |
| `maltego` | Link analysis / OSINT GUI | `maltego` |
| `spiderfoot` | Automated OSINT on IPs/domains | `spiderfoot -l 127.0.0.1:5001` |
| `dnsx` | Fast DNS toolkit | `dnsx -l subs.txt -a -resp` |
| `httpx` | Probe HTTP/S from host lists | `httpx -l hosts.txt -status-code -title` |
| `nuclei` | Template-based scanner | `nuclei -u https://target.com -t cves/` |
| `naabu` | Port scanner with nmap integration | `naabu -host target.com -p -` |
| `whatweb` | Web fingerprinting | `whatweb -a 3 https://target.com` |
| `wafw00f` | WAF detection | `wafw00f https://target.com` |

## Typical Flow

```
# 1. Subdomain enum
subfinder -d target.com | tee subs.txt
amass enum -passive -d target.com >> subs.txt

# 2. Resolve + probe live hosts
cat subs.txt | dnsx -resp | tee resolved.txt
cat resolved.txt | httpx -title -status-code | tee live.txt

# 3. Port scan live hosts
naabu -list live.txt -p - | tee ports.txt

# 4. Vuln scan
nuclei -list live.txt -t cves/ -t exposures/
```

## Config files → `configs/`

Put tool-specific configs here (e.g. `amass/config.ini` with API keys, `subfinder/provider-config.yaml`).

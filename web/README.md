# Web & Webapp

**Groups:** `blackarch-webapp` · `blackarch-fuzzer` · `blackarch-proxy`

---

## Key Tools

| Tool | What it does | Quick start |
|------|-------------|-------------|
| `sqlmap` | Automated SQL injection | `sqlmap -u "http://target/page?id=1" --dbs` |
| `nikto` | Web server scanner | `nikto -h https://target.com` |
| `ffuf` | Fast web fuzzer (dirs, vhosts, params) | `ffuf -w wordlist.txt -u https://target/FUZZ` |
| `gobuster` | Dir/DNS/vhost bruteforce | `gobuster dir -u https://target -w /usr/share/wordlists/dirb/common.txt` |
| `feroxbuster` | Recursive content discovery | `feroxbuster -u https://target -w wordlist.txt` |
| `wfuzz` | Web fuzzer | `wfuzz -c -z file,wordlist.txt https://target/FUZZ` |
| `burpsuite` | Web proxy / manual testing | `burpsuite` |
| `zaproxy` | OWASP ZAP — automated scanner | `zaproxy` |
| `commix` | Command injection exploiter | `commix --url="http://target/?param=val"` |
| `xsstrike` | XSS scanner | `xsstrike -u "http://target/?q=test"` |
| `dalfox` | Fast XSS scanner | `dalfox url "http://target/?q=test"` |
| `wpscan` | WordPress scanner | `wpscan --url https://target.com --enumerate u,p` |
| `joomscan` | Joomla scanner | `joomscan -u https://target.com` |
| `arjun` | HTTP parameter discovery | `arjun -u https://target/page` |
| `jwt_tool` | JWT analysis & attacks | `jwt_tool <token>` |

## Typical Flow

```
# 1. Fingerprint
whatweb https://target.com
nikto -h https://target.com

# 2. Directory/file discovery
ffuf -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files.txt \
     -u https://target.com/FUZZ -mc 200,301,302

# 3. Parameter fuzzing
arjun -u https://target.com/search

# 4. Injection testing
sqlmap -u "https://target.com/item?id=1" --level 3 --risk 2 --batch
```

## Wordlists

SecLists is at `/usr/share/seclists/` after installing `seclists`.

## Config files → `configs/`

Burp project files, ZAP session files, sqlmap tamper scripts.

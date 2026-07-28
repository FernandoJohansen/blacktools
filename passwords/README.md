# Passwords & Crypto

**Groups:** `blackarch-cracker` · `blackarch-crypto` · `blackarch-wordlist`

---

## Key Tools

| Tool | What it does | Quick start |
|------|-------------|-------------|
| `hashcat` | GPU password cracker | `hashcat -m 1000 hash.txt rockyou.txt` |
| `john` | CPU password cracker | `john --wordlist=rockyou.txt hash.txt` |
| `hydra` | Online brute-force (SSH, FTP, HTTP…) | `hydra -l user -P wordlist.txt ssh://<ip>` |
| `medusa` | Parallel brute-forcer | `medusa -h <ip> -u user -P wordlist.txt -M ssh` |
| `crowbar` | RDP/VNC/SSH key brute-force | `crowbar -b rdp -s <ip>/32 -u user -C wordlist.txt` |
| `ncrack` | Network auth cracker | `ncrack -p ssh <ip>` |
| `haiti` | Hash type identifier | `haiti '<hash>'` |
| `hashid` | Identify hash types | `hashid '<hash>'` |
| `name-that-hash` | Hash identifier | `nth --text '<hash>'` |
| `crunch` | Wordlist generator | `crunch 8 8 abcdefghijklmnopqrstuvwxyz0123456789` |
| `cewl` | Wordlist from website | `cewl https://target.com -d 2 -m 5 -w words.txt` |
| `cupp` | Custom wordlist from profile | `cupp -i` |
| `rsmangler` | Wordlist mangler | `rsmangler --file words.txt` |
| `ophcrack` | Windows LM/NTLM cracker (rainbow) | `ophcrack` |
| `fcrackzip` | ZIP password cracker | `fcrackzip -v -u -D -p rockyou.txt file.zip` |

## Hash Mode Reference (hashcat -m)

```
0     MD5
100   SHA1
1000  NTLM
1800  sha512crypt (Linux)
3200  bcrypt
5600  NetNTLMv2
13100 Kerberoast (TGS-REP)
18200 AS-REP Roast
```

## Typical Flows

```
# Identify hash
haiti '<hash_value>'

# Crack NTLM dump
hashcat -m 1000 ntlm.txt /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule

# Kerberoast
hashcat -m 13100 kerb.txt rockyou.txt --force

# SSH brute-force
hydra -l root -P /usr/share/wordlists/rockyou.txt -t 4 ssh://<ip>
```

## Wordlists location (after install)

```
/usr/share/wordlists/rockyou.txt.gz    # classic
/usr/share/seclists/                   # SecLists
/usr/share/wordlists/                  # other lists
```

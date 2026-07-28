# Forensics & Malware Analysis

**Groups:** `blackarch-forensic` · `blackarch-anti-forensic` · `blackarch-malware` · `blackarch-stego`

---

## Key Tools

| Tool | What it does | Quick start |
|------|-------------|-------------|
| `volatility3` | Memory forensics | `vol -f memory.dmp windows.pslist` |
| `autopsy` | Digital forensics GUI | `autopsy` |
| `sleuthkit` | CLI forensics toolkit | `fls image.dd` |
| `binwalk` | Firmware/file carving | `binwalk -e file` |
| `foremost` | File carving by header | `foremost -i disk.img -o output/` |
| `scalpel` | File carving | `scalpel disk.img -o output/` |
| `bulk_extractor` | Extract features from disk images | `bulk_extractor -o out/ disk.img` |
| `testdisk` | Partition/file recovery | `testdisk disk.img` |
| `photorec` | Photo/file recovery | `photorec disk.img` |
| `exiftool` | Read/write metadata | `exiftool file.jpg` |
| `yara` | Malware pattern matching | `yara rules.yar target/` |
| `clamav` | Antivirus scanner | `clamscan -r /suspicious/` |
| `pdf-parser` | PDF structure analyzer | `pdf-parser malicious.pdf` |
| `peepdf` | PDF malware analysis | `peepdf malicious.pdf` |
| `oletools` | Office macro analysis | `olevba malicious.docx` |
| `steghide` | Steganography hide/extract | `steghide extract -sf image.jpg` |
| `zsteg` | PNG/BMP stego detection | `zsteg image.png` |
| `stegsolve` | Image stego solver GUI | `stegsolve` |

## Volatility 3 Quick Reference

```bash
# List processes
vol -f mem.dmp windows.pslist

# Network connections
vol -f mem.dmp windows.netstat

# Dump process memory
vol -f mem.dmp windows.dumpfiles --pid 1234

# Registry hives
vol -f mem.dmp windows.hivelist
vol -f mem.dmp windows.hashdump

# Linux
vol -f mem.dmp linux.pslist
vol -f mem.dmp linux.bash
```

## Malware Triage Flow

```bash
# 1. Static
file malware.exe
strings -n 6 malware.exe | grep -iE 'http|cmd|powershell|reg'
exiftool malware.exe
yara /usr/share/yara-rules/ malware.exe

# 2. Office macros
olevba suspicious.docx
oledump.py suspicious.doc

# 3. PDF
peepdf malicious.pdf
pdf-parser --search javascript malicious.pdf

# 4. Dynamic (in a VM!)
strace ./malware
wireshark & then run malware
```

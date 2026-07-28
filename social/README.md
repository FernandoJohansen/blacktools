# Social Engineering & Mobile

**Groups:** `blackarch-social` · `blackarch-mobile`

---

## Key Tools

| Tool | What it does | Quick start |
|------|-------------|-------------|
| `setoolkit` | Social-Engineer Toolkit | `setoolkit` |
| `gophish` | Phishing campaign manager | `./gophish` (web UI on :3333) |
| `evilginx3` | Reverse proxy phishing (MFA bypass) | `evilginx3` |
| `king-phisher` | Phishing campaign framework | `king-phisher-server` |
| `maltego` | Link analysis for OSINT | `maltego` |
| `phoneinfoga` | Phone number OSINT | `phoneinfoga scan -n +1234567890` |
| `sherlock` | Username OSINT across platforms | `sherlock username` |
| `holehe` | Check email on platforms | `holehe email@example.com` |
| `maigret` | Username OSINT (extended) | `maigret username` |
| `apktool` | APK decompile/recompile | `apktool d app.apk` |
| `jadx` | APK Java decompiler | `jadx app.apk` or `jadx-gui app.apk` |
| `adb` | Android Debug Bridge | `adb shell`, `adb pull /data/...` |
| `objection` | Mobile runtime exploration (Frida) | `objection -g com.app explore` |
| `mob-sf` | Mobile Security Framework | Docker: auto-setup |
| `androguard` | Android malware analysis | `androguard analyze app.apk` |
| `idb` | iOS app analysis | `idb` |

## SET Quick Flows

```bash
setoolkit
# → 1) Social-Engineering Attacks
# → 2) Website Attack Vectors
# → 3) Credential Harvester
# → 2) Site Cloner → enter target URL
# Serves fake login on port 80, captures creds
```

## Android Pentest Flow

```bash
# Decompile APK
apktool d app.apk -o app_src/

# Look for secrets
grep -r "api_key\|password\|secret\|token" app_src/ --include="*.xml" --include="*.smali"

# Decompile to Java
jadx -d app_java/ app.apk

# Dynamic analysis with Frida/objection
adb install app.apk
objection -g com.target.app explore
# → android sslpinning disable
# → android hooking list classes
```

## Username OSINT

```bash
sherlock username
maigret username --top-sites 500
holehe target@email.com
phoneinfoga scan -n "+551199999999"
```

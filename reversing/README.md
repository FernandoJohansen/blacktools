# Reverse Engineering

**Groups:** `blackarch-reversing` · `blackarch-binary` · `blackarch-disassembler` · `blackarch-decompiler` · `blackarch-debugger`

---

## Key Tools

| Tool | What it does | Quick start |
|------|-------------|-------------|
| `ghidra` | NSA decompiler / RE suite | `ghidra` |
| `radare2` | CLI disassembler/debugger | `r2 -A binary` |
| `cutter` | Radare2 GUI | `cutter binary` |
| `rizin` | Radare2 fork | `rizin -A binary` |
| `gdb` | GNU debugger | `gdb ./binary` |
| `pwndbg` | GDB plugin for exploit dev | auto-loaded with gdb if installed |
| `peda` | GDB PEDA plugin | `gdb` → `pattern create 200` |
| `pwntools` | CTF exploit dev library | `python3 -c 'from pwn import *'` |
| `angr` | Symbolic execution | `python3 -c 'import angr'` |
| `frida` | Dynamic instrumentation | `frida -U com.app.target` |
| `strace` | Trace system calls | `strace -f ./binary` |
| `ltrace` | Trace library calls | `ltrace ./binary` |
| `strings` | Extract printable strings | `strings -n 8 binary` |
| `binwalk` | Firmware analysis & extraction | `binwalk -e firmware.bin` |
| `file` | Identify file type | `file binary` |
| `xxd` | Hex dump | `xxd binary | head -40` |
| `objdump` | Object file disassembly | `objdump -d binary` |
| `readelf` | ELF analysis | `readelf -a binary` |
| `checksec` | Binary security flags | `checksec --file=binary` |

## Typical Flow

```bash
# 1. Identify
file target
checksec --file=target
strings -n 8 target | less

# 2. Static analysis
r2 -A target
# in r2:  afl  (list functions)  pdf @ main  (disassemble main)

# 3. Dynamic analysis
strace ./target
ltrace ./target
gdb ./target

# 4. Decompile
# Open in ghidra → import → analyze → CodeBrowser
```

## GDB Quick Reference

```
run                   start
break *0x400abc       breakpoint at address
info registers        show regs
x/20x $rsp            dump stack
ni / si               next / step instruction
finish                run to return
vmmap                 (pwndbg) memory map
```

## Pwntools Template

```python
from pwn import *

context.binary = elf = ELF('./target')
p = process('./target')  # or remote('host', port)

# ... build exploit ...

p.interactive()
```

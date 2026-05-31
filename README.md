# LAN-LOK
Revitalizing the Antarctic LAN game, LAN-LOK, from the early 1990s

Blog post here:
https://alphapixeldev.com/lan-lok-the-antarctic-dos-sabotage-game-lost-for-34-years-part-1/

Github here:
https://github.com/AlphaPixel/LAN-LOK

Playable on Archive.org via browser-based emulator:
https://archive.org/details/Lanlok

Original DOS EXE in archival/Lanlok.zip

---

## Decompilation

Branch `1-attempt-reverse-engineering-via-claude-code` contains a complete decompilation of
the LAN-LOK DOS executable back to Microsoft QuickBASIC source code.

**Status: complete** — all 44 named ASM functions translated; 1,975 lines of BASIC;
compiles cleanly under [QB64-PE](https://github.com/QB64-Phoenix-Edition/QB64pe/releases).

### Key files

| File | Description |
|------|-------------|
| `lanlokre.bas` | Decompiled BASIC source (QB64-PE compatible) |
| `lanlok.asm` | Ghidra disassembly of the original DOS executable (ground truth) |
| `LANLOKDS.BIN` | Data segment dump (string/float constants) |
| `archival/Lanlok.zip` | Original DOS EXE |
| `WORK_PLAN.md` | Function inventory, methodology, translation reference |
| `PROGRESS_LOG.md` | Session-by-session decompilation log |

### Methodology

The executable was disassembled with Ghidra (after converting QuickBASIC's floating-point
emulation INT stubs to x87 instructions). The resulting ASM was translated function-by-function
to QB64-compatible BASIC over 21 AI-assisted sessions (Claude Sonnet 4.6, May 2026).

Techniques used:
- Pascal-convention CALLF decoding for BASIC runtime calls (LOCATE, COLOR, LINE, SOUND, etc.)
- FP stack tracking for float variable assignments and comparisons
- Calibrated delay-loop conversion to `_DELAY` (required for QB64 timing correctness)
- Semantic variable and label renaming with glossary (original DS/CS addresses preserved in comments)
- Cross-verification of all constants and strings against `LANLOKDS.BIN`


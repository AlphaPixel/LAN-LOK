# LAN-LOK reverse engineering notes

Repo contents:

* MEMDUMP_ORIG.BIN : A full-memory dump from DOSBOX, taken while the game was running (breakpoint was taken partially through the introduction). This was used to isolate the code segments (01a2:0000, 0d75:0000, and 0e71:0000), and the data/stack segment (1997:0000).

* MEMDUMP.BIN : Same as above, but trimmed to contain only the program's data area, and also processed to convert all of the Intel floating-point emulation calls (INT 34 - INT 3D) to appropriate x87 instructions.  This was given to Ghidra for disassembly.

* LANLOKDS.BIN : Same memory dump, cropped to align with the start of the data segment (1997:0000). Used to check constant and string references in the disassembly.

* LANLOK.ASM : Disassembly from Ghidra. Some known QuickBasic runtime function calls have been named with the corresponding BASIC instruction.

* LANLOKRE.BAS : Completed QuickBASIC decompilation (1,975 lines). All raw ASM replaced with
  BASIC. Compiles cleanly under QB64-PE. Variables and labels use semantic names (e.g. `drawX!`,
  `score!`, `LAlAnim`) established during a global renaming pass (session 12, 2026-05-28).
  Original DS/CS address names are preserved in inline comments for cross-reference with LANLOK.ASM.
  A 35+ symbol glossary is at the top of the file (lines ~9-143).

* LANLOK.ASM : Ghidra disassembly of the code segment, with QuickBASIC runtime calls named.
  Used as ground truth throughout decompilation; do not modify.

Decompilation completed 2026-05-30 over 21 AI-assisted sessions (Claude Sonnet 4.6).
See PROGRESS_LOG.md for detailed session notes.


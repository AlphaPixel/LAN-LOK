# LAN-LOK reverse engineering notes

Repo contents:

* MEMDUMP_ORIG.BIN : A full-memory dump from DOSBOX, taken while the game was running (breakpoint was taken partially through the introduction). This was used to isolate the code segments (01a2:0000, 0d75:0000, and 0e71:0000), and the data/stack segment (1997:0000).

* MEMDUMP.BIN : Same as above, but trimmed to contain only the program's data area, and also processed to convert all of the Intel floating-point emulation calls (INT 34 - INT 3D) to appropriate x87 instructions.  This was given to Ghidra for disassembly.

* LANLOKDS.BIN : Same memory dump, cropped to align with the start of the data segment (1997:0000). Used to check constant and string references in the disassembly.

* LANLOK.ASM : Disassembly from Ghidra. Some known QuickBasic runtime function calls have been named with the corresponding BASIC instruction.

* LANLOKRE.BAS : Working file for the QuickBasic decompilation. Variable names and function/subroutine labels are referred to by DS/CS address respectively, to help keep the decompilation consistent; these will be globally replaced with readable names once the first pass is done.

More notes coming soon ...


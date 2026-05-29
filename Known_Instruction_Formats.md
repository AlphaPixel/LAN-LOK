# Initial notes

Unless otherwise indicated, QuickBasic runtime functions/subroutines use Pascal argument ordering - 
the first argument of the function is pushed first, second argument next, and so on. This is reverse
from the order typically used in most C language calling conventions.

# LOCATE

The QuickBasic LOCATE statement uses a variable argument list, with each argument including a type
indicator, followed by the value. The final PUSH statement is an indication of the total number of 16-bit
words pushed previously (each type and value counted separately).

As an example, a call to LOCATE with arguments (in pushed order):

1, 25, 1, 75, 4

would correspond to the following LOCATE statement in the BASIC code:

LOCATE 25, 75

# COLOR

The COLOR statement is similar to LOCATE, and uses the same variable argument list.

In this case, the parameters will differ depending on whether to set only foreground text color, or both foreground and
background. A foreground-only color change would have arguments like:

1, 13, 2

This would correspond to the BASIC statement "COLOR 13". For both foreground and background, this argument list:

1, 13, 1, 6, 4

would correspond to the BASIC statement "COLOR 13,6".

## Observed usage in this executable

All COLOR calls found in lanlok.asm use the 3-argument (foreground-only) form. No 5-argument
(foreground + background) COLOR call has been observed. When translating, always emit `COLOR fg`
with a single argument. The "2" at the end of every COLOR push sequence is the argument count
(2 words = 1 type-indicator + 1 value), NOT a background color.

## Observed LOCATE pattern

In addition to the 5-push full form `1, row, 1, col, 4`, a 4-push short form also appears when
the row is a compile-time integer constant:

    row_literal, 1, col, 4

Both forms decode to `LOCATE row, col` (two arguments). The trailing `4` is the word count;
the `1` before col is the col's type indicator. No LOCATE call in this executable supplies more
than 2 arguments (row and col).

# OPEN

The runtime functions labeled SUB_0e71_4226 is for the OPEN statement. The syntax for OPEN is:

OPEN "FILENAME" FOR INPUT AS #1

In the parameter list, the first argument is the string for the filename. Second is the file number.
Third is record length, 0xffff indicates default which does not need to be specified in syntax. The
fourth and last argument is the file open mode, 1 is INPUT and 2 is OUTPUT.

# CLOSE

The runtime function labeled SUB_0e71_4452 is for the CLOSE statement. The syntax for CLOSE is:

CLOSE #1

The one argument specifies the file number to close.

# File INPUT

Each input from the file is comprised of three calls.

SUB_0e71_636c indicates the file number to use for the next operation. It takes only
one parameter, the file number.

SUB_0e71_7e1a and SUB_0e71_7e20 specify the type and location to read data into.
SUB_0e71_7e1a reads a float numeric type, and SUB_0e71_7e20 reads a string.
For each, the first two parameters are segment and offset for the target. The string
version has a third argument that is set to zero, its purpose is not known.

Finally, the call labeled PRINT_USING_END appears to be mislabeled, it acts as a
terminator for the I/O routines.

Combining the file number from SUB_0e71_636c, and value location from SUB_0e71_7e1a
or SUB_0e71_7e20, the final statement would be rendered as:

INPUT #1, FloatValue!
or
INPUT #1, StringValue$

# File PRINT

As with file input, output / PRINT to file uses three functions.

SUB_0e71_764b indicates the file number to use for the next operation.

SUB_0e71_7864 indicates the next PRINT operation goes to a file instead of the screen.

Finally, there will be a normally specified PRINT statement for string or floating point
numeric.

The final statement is rendered as:

PRINT #1, FloatValue!

or

PRINT #1, StringValue$

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


ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .include "animations.h.s"
                              1 .globl _spr_aliens_0
                              2 .globl _spr_aliens_1
                              3 .globl _spr_aliens_2
                              4 .globl _spr_aliens_3
                              5 .globl _spr_aliens_4
                              6 .globl _spr_aliens_5
                              7 
                              8 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              2 
   4BFC                       3 enemy_void_anim::
   4BFC 00 48                 4     .dw _spr_aliens_0
   4BFE 80 48                 5     .dw _spr_aliens_1
   4C00 00 00                 6     .dw 0x0000
   4C02 FC 4B                 7     .dw enemy_void_anim
                              8 
                              9 

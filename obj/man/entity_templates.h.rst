ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .globl tmpl_enemy_void
                              2 .globl tmpl_enemy_o
                              3 .globl tmpl_enemy_p
                              4 .globl tmpl_player
                              5 .globl _spr_alien_void
                              6 .globl _spr_aliens_0
                              7 .globl _spr_aliens_2
                              8 .globl _spr_aliens_4
                              9 .globl _spr_player_0
                             10 
                             11 
                     0010    12 size_of_tmpl = 16 ;; number of bytes occupied by each entity
                     000A    13 max_enemies = 10
                     00A0    14 size_of_array = size_of_tmpl * max_enemies

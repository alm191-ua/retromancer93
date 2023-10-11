ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 
                              2 .globl man_entity_init
                              3 .globl man_enemy_create
                              4 .globl man_player_create
                              5 .globl man_enemy_set4destruction
                              6 .globl man_enemy_destroy
                              7 .globl man_enemy_forall
                              8 .globl man_enemy_update
                              9 
                             10 .globl enemies_array
                             11 .globl player
                             12 
                     0000    13 type_invalid    =   0
                     0001    14 type_enemy_o    =   1
                     0002    15 type_enemy_p    =   2
                     0003    16 type_enemy_void =   3
                     0004    17 type_player     =   4
                     0005    18 type_trigger    =   5
                             19 
                     0000    20 e_cmp_default   =   0x00
                     0001    21 e_cmp_ia        =   0x01
                     0002    22 e_cmp_movable   =   0x02
                     0004    23 e_cmp_render    =   0x04
                     0008    24 e_cmp_collider  =   0x08
                     0010    25 e_cmp_animated  =   0x10
                     0020    26 e_cmp_input     =   0x20
                     0080    27 e_cmp_dead      =   0x80
                             28 
                             29 
                     0032    30 LANE1_Y = 50
                     0078    31 LANE2_Y = 120
                             32 
                     000A    33 max_enemies = 10
                             34 
                     0000    35 e_type = 0
                     0001    36 e_comp = 1
                     0002    37 e_x = 2
                     0003    38 e_y = 3
                     0004    39 e_sprite = 4
                     0006    40 e_ia = 6
                     0008    41 e_anim = 8
                     000A    42 e_anim_counter = 10
                     000B    43 e_collides = 11
                             44 
                     000C    45 e_h = 12
                     000D    46 e_w = 13
                             47 

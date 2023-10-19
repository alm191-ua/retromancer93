ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 
                              2 .globl man_entity_init
                              3 .globl man_enemy_create
                              4 .globl man_player_create
                              5 .globl man_enemy_set4destruction
                              6 .globl man_enemy_set4dead
                              7 .globl man_enemy_destroy
                              8 .globl man_enemy_forall
                              9 .globl man_enemy_update
                             10 .globl man_entity_forall
                             11 
                             12 .globl enemies_array
                             13 .globl player
                             14 .globl first_enemy
                             15 
                     0000    16 type_invalid    =   0
                     0001    17 type_enemy_o    =   1
                     0002    18 type_enemy_p    =   2
                     0003    19 type_enemy_void =   3
                     0004    20 type_player     =   4
                     0005    21 type_trigger    =   5
                             22 
                     0000    23 e_cmp_default   =   0x00
                     0001    24 e_cmp_ia        =   0x01
                     0002    25 e_cmp_movable   =   0x02
                     0004    26 e_cmp_render    =   0x04
                     0008    27 e_cmp_collider  =   0x08
                     0010    28 e_cmp_animated  =   0x10
                     0020    29 e_cmp_input     =   0x20
                     0040    30 e_cmp_set4dead  =   0x40
                     0080    31 e_cmp_dead      =   0x80
                             32 
                             33 
                     0032    34 LANE1_Y = 50
                     0078    35 LANE2_Y = 120
                             36 
                     002A    37 LANE1_Y_PLAYER = LANE1_Y-8
                     0070    38 LANE2_Y_PLAYER = LANE2_Y-8
                             39 
                     0006    40 POS_X_PLAYER = 6
                     0047    41 INIT_X_ENEMY = 71 ;; 79 (end of screen) - 8 (width of sprite)
                             42 
                     000A    43 TRIGGER_LENGTH = 10 ;; TODO: hay que hacer pruebas a ver cuál es la mejor distancia
                     0010    44 KILLING_ENEMIES_POS = POS_X_PLAYER + TRIGGER_LENGTH
                             45 
                     0002    46 default_enemies_points_value = 2
                             47 
                     000A    48 max_enemies = 10
                             49 
                     0000    50 e_type = 0
                     0001    51 e_comp = 1
                     0002    52 e_x = 2
                     0003    53 e_y = 3
                     0004    54 e_sprite = 4
                     0006    55 e_ia = 6
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                     0008    56 e_anim = 8
                     000A    57 e_anim_counter = 10
                     000B    58 e_collides = 11
                             59 
                     000C    60 e_h = 12
                     000D    61 e_w = 13
                             62 

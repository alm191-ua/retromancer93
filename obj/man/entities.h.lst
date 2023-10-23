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
                             11 .globl space_for_new_enemy
                             12 .globl return_last_enemy
                             13 
                             14 .globl enemies_array
                             15 .globl player
                             16 .globl player_attack
                             17 .globl first_enemy
                             18 
                     0000    19 type_invalid        =   0
                     0001    20 type_enemy_o        =   1
                     0002    21 type_enemy_p        =   2
                     0003    22 type_enemy_void     =   3
                     0004    23 type_player         =   4
                     0005    24 type_trigger        =   5
                     0006    25 type_player_attack  =   6
                             26 
                     0000    27 e_cmp_default   =   0x00
                     0001    28 e_cmp_ia        =   0x01
                     0002    29 e_cmp_movable   =   0x02
                     0004    30 e_cmp_render    =   0x04
                     0008    31 e_cmp_collider  =   0x08
                     0010    32 e_cmp_animated  =   0x10
                     0020    33 e_cmp_input     =   0x20
                     0040    34 e_cmp_set4dead  =   0x40
                     0080    35 e_cmp_dead      =   0x80
                             36 
                             37 
                     0032    38 LANE1_Y = 50
                     0078    39 LANE2_Y = 120
                             40 
                     0032    41 LANE1_Y_PLAYER = LANE1_Y ;; / 16x16 enemy sprites -> LANE1_Y-8
                     0078    42 LANE2_Y_PLAYER = LANE2_Y ;; \ 16x32 enemy sprites -> LANE1_Y
                             43 
                     0006    44 POS_X_PLAYER = 6
                     0045    45 INIT_X_ENEMY = 69 ;; 79 (end of screen) - 10 (width of sprite)
                     000E    46 POS_X_ATTACK = POS_X_PLAYER + 8 ; (player sprite's width)
                             47 
                     0014    48 TRIGGER_LENGTH = 20 ;; TODO: hay que hacer pruebas a ver cuál es la mejor distancia
                     001A    49 KILLING_ENEMIES_POS = POS_X_PLAYER + TRIGGER_LENGTH
                             50 
                     0001    51 default_enemies_points_value = 1
                             52 
                     000A    53 max_enemies = 10
                             54 
                     0000    55 e_type          = 0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                     0001    56 e_comp          = 1
                     0002    57 e_x             = 2
                     0003    58 e_y             = 3
                     0004    59 e_sprite        = 4  ; 2bytes
                     0006    60 e_ia            = 6  ; 2bytes
                     0008    61 e_anim          = 8  ; 2bytes
                     000A    62 e_death_anim    = 10 ; 2bytes
                     000C    63 e_anim_counter  = 12
                     000D    64 e_collides      = 13
                     000E    65 e_h             = 14
                     000F    66 e_w             = 15
                             67 
                             68 

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .include "animations.h.s"
                              1 .globl _spr_alien_void_0
                              2 .globl _spr_alien_void_1
                              3 .globl _spr_alien_void_2
                              4 .globl _spr_alien_void_3
                              5 .globl _spr_alien_void_4
                              6 .globl _spr_alien_void_5
                              7 
                              8 .globl _spr_alien_o_0
                              9 .globl _spr_alien_o_1
                             10 .globl _spr_alien_o_2
                             11 .globl _spr_alien_o_3
                             12 .globl _spr_alien_o_4
                             13 .globl _spr_alien_o_5
                             14 
                             15 .globl _spr_alien_p_0
                             16 .globl _spr_alien_p_1
                             17 .globl _spr_alien_p_2
                             18 .globl _spr_alien_p_3
                             19 .globl _spr_alien_p_4
                             20 .globl _spr_alien_p_5
                             21 
                             22 .globl _spr_player_0
                             23 .globl _spr_player_1
                             24 .globl _spr_player_tp_0
                             25 .globl _spr_player_tp_1
                             26 .globl _spr_player_tp_2
                             27 .globl _spr_player_tp_3
                             28 .globl _spr_player_tp_4
                             29 .globl _spr_player_tp_5
                             30 
                             31 .globl _spr_player_attack_05
                             32 .globl _spr_player_attack_06
                             33 .globl _spr_player_attack_07
                             34 .globl _spr_player_attack_08
                             35 .globl _spr_player_attack_09
                             36 .globl _spr_player_attack_10
                             37 .globl _spr_player_attack_11
                             38 .globl _spr_player_attack_12
                             39 .globl _spr_player_attack_13
                             40 .globl _spr_player_attack_14
                             41 
                             42 
                             43 .globl enemy_void_death_anim
                             44 .globl enemy_o_death_anim
                             45 .globl enemy_p_death_anim
                             46 
                             47 .globl enemy_void_anim
                             48 .globl enemy_o_anim
                             49 .globl enemy_p_anim
                             50 
                             51 .globl player_standby_anim
                             52 .globl player_tp_anim
                             53 .globl player_tp_mirror_anim
                             54 .globl player_attack_null
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             55 .globl player_attack_o
                             56 .globl player_attack_p
                             57 
                             58 .globl sys_animation_update
                             59 .globl sys_animation_update_fast
                             60 .globl sys_animation_update_custom_speed
                             61 .globl target_player_position
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              2 .include "man/entities.h.s"
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
                             14 .globl player_attack
                             15 .globl first_enemy
                             16 
                     0000    17 type_invalid        =   0
                     0001    18 type_enemy_o        =   1
                     0002    19 type_enemy_p        =   2
                     0003    20 type_enemy_void     =   3
                     0004    21 type_player         =   4
                     0005    22 type_trigger        =   5
                     0006    23 type_player_attack  =   6
                             24 
                     0000    25 e_cmp_default   =   0x00
                     0001    26 e_cmp_ia        =   0x01
                     0002    27 e_cmp_movable   =   0x02
                     0004    28 e_cmp_render    =   0x04
                     0008    29 e_cmp_collider  =   0x08
                     0010    30 e_cmp_animated  =   0x10
                     0020    31 e_cmp_input     =   0x20
                     0040    32 e_cmp_set4dead  =   0x40
                     0080    33 e_cmp_dead      =   0x80
                             34 
                             35 
                     0032    36 LANE1_Y = 50
                     0078    37 LANE2_Y = 120
                             38 
                     0032    39 LANE1_Y_PLAYER = LANE1_Y ;; / 16x16 enemy sprites -> LANE1_Y-8
                     0078    40 LANE2_Y_PLAYER = LANE2_Y ;; \ 16x32 enemy sprites -> LANE1_Y
                             41 
                     0006    42 POS_X_PLAYER = 6
                     0045    43 INIT_X_ENEMY = 69 ;; 79 (end of screen) - 10 (width of sprite)
                     000E    44 POS_X_ATTACK = POS_X_PLAYER + 8 ; (player sprite's width)
                             45 
                     0014    46 TRIGGER_LENGTH = 20 ;; TODO: hay que hacer pruebas a ver cuál es la mejor distancia
                     001A    47 KILLING_ENEMIES_POS = POS_X_PLAYER + TRIGGER_LENGTH
                             48 
                     0002    49 default_enemies_points_value = 2
                             50 
                     000A    51 max_enemies = 10
                             52 
                     0000    53 e_type          = 0
                     0001    54 e_comp          = 1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                     0002    55 e_x             = 2
                     0003    56 e_y             = 3
                     0004    57 e_sprite        = 4  ; 2bytes
                     0006    58 e_ia            = 6  ; 2bytes
                     0008    59 e_anim          = 8  ; 2bytes
                     000A    60 e_death_anim    = 10 ; 2bytes
                     000C    61 e_anim_counter  = 12
                     000D    62 e_collides      = 13
                     000E    63 e_h             = 14
                     000F    64 e_w             = 15
                             65 
                             66 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              3 .include "man/entity_templates.h.s"
                              1 .globl tmpl_enemy_void
                              2 .globl tmpl_enemy_o
                              3 .globl tmpl_enemy_p
                              4 .globl tmpl_player
                              5 .globl tmpl_player_attack
                              6 .globl _spr_alien_void
                              7 .globl _spr_aliens_0
                              8 .globl _spr_aliens_2
                              9 .globl _spr_aliens_4
                             10 .globl _spr_player_0
                             11 .globl _spr_player_attack_04
                             12 
                             13 
                     0010    14 size_of_tmpl = 16 ;; number of bytes occupied by each entity
                     000A    15 max_enemies = 10
                     00A0    16 size_of_array = size_of_tmpl * max_enemies
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              4 .include "man/game.h.s"
                              1 .globl frame_counter
                              2 .globl sys_game_init
                              3 .globl sys_game_play
                              4 .globl sys_game_start
                              5 .globl sys_game_pause
                              6 .globl sys_game_check_finished
                              7 
                              8 .globl sys_game_inc_frames_counter
                              9 .globl sys_game_inc_points
                             10 .globl sys_game_dec_points
                             11 
                             12 ;; game states
                     0001    13 game_st_finish  = 1
                     0002    14 game_st_pause   = 2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              5 .include "render.h.s"
                              1 .globl sys_render_init
                              2 .globl sys_render_update
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              6 
                     000F     7 animation_speed = 15
                              8 
   73FD                       9 target_player_position::
   73FD 32                   10     .db #LANE1_Y_PLAYER
                             11 
   73FE                      12 enemy_null_anim:
   73FE 40 6C                13     .dw _spr_alien_void_5 
   7400 00 00                14     .dw 0x0000
   7402 FE 73                15     .dw enemy_null_anim
                             16 
   7404                      17 enemy_void_death_anim::
   7404 C0 69                18     .dw _spr_alien_void_3 
   7406 00 6B                19     .dw _spr_alien_void_4 
   7408 40 6C                20     .dw _spr_alien_void_5 
   740A 01 00                21     .dw 0x0001
   740C AF 72                22     .dw man_enemy_set4destruction
   740E FE 73                23     .dw enemy_null_anim
                             24 
   7410                      25 enemy_o_death_anim::
   7410 40 62                26     .dw _spr_alien_o_3 
   7412 80 63                27     .dw _spr_alien_o_4 
   7414 C0 64                28     .dw _spr_alien_o_5 
   7416 01 00                29     .dw 0x0001
   7418 AF 72                30     .dw man_enemy_set4destruction
   741A FE 73                31     .dw enemy_null_anim
                             32 
   741C                      33 enemy_p_death_anim::
   741C C0 5A                34     .dw _spr_alien_p_3 
   741E 00 5C                35     .dw _spr_alien_p_4 
   7420 40 5D                36     .dw _spr_alien_p_5 
   7422 01 00                37     .dw 0x0001
   7424 AF 72                38     .dw man_enemy_set4destruction
   7426 FE 73                39     .dw enemy_null_anim
                             40 
   7428                      41 enemy_void_anim::
   7428 00 66                42     .dw _spr_alien_void_0
   742A 40 67                43     .dw _spr_alien_void_1
   742C 80 68                44     .dw _spr_alien_void_2
   742E 00 00                45     .dw 0x0000
   7430 28 74                46     .dw enemy_void_anim
                             47 
   7432                      48 enemy_o_anim::
   7432 80 5E                49     .dw _spr_alien_o_0
   7434 C0 5F                50     .dw _spr_alien_o_1
   7436 00 61                51     .dw _spr_alien_o_2
   7438 00 00                52     .dw 0x0000
   743A 32 74                53     .dw enemy_o_anim
                             54 
   743C                      55 enemy_p_anim::
   743C 00 57                56     .dw _spr_alien_p_0
   743E 40 58                57     .dw _spr_alien_p_1
   7440 80 59                58     .dw _spr_alien_p_2
   7442 00 00                59     .dw 0x0000
   7444 3C 74                60     .dw enemy_p_anim
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             61 
   7446                      62 player_standby_anim::
   7446 00 55                63     .dw _spr_player_0
   7448 00 56                64     .dw _spr_player_1
   744A 00 00                65     .dw 0x0000
   744C 46 74                66     .dw player_standby_anim
                             67 
   744E                      68 player_tp_anim::
   744E 00 4F                69     .dw _spr_player_tp_0
   7450 00 50                70     .dw _spr_player_tp_1
                             71     ;.dw _spr_player_tp_2
   7452 00 52                72     .dw _spr_player_tp_3
                             73     ;.dw _spr_player_tp_4
   7454 00 54                74     .dw _spr_player_tp_5
   7456 01 00                75     .dw 0x0001
   7458 E5 74                76     .dw move_player
   745A 5C 74                77     .dw player_tp_mirror_anim
                             78 
   745C                      79 player_tp_mirror_anim::
   745C 00 54                80     .dw _spr_player_tp_5
                             81     ;.dw _spr_player_tp_4
   745E 00 52                82     .dw _spr_player_tp_3
                             83     ;.dw _spr_player_tp_2
   7460 00 50                84     .dw _spr_player_tp_1
   7462 00 4F                85     .dw _spr_player_tp_0
   7464 00 00                86     .dw 0x0000
   7466 46 74                87     .dw player_standby_anim
                             88 
                             89 
   7468                      90 player_attack_null::
   7468 00 49                91     .dw _spr_player_attack_09
   746A 00 00                92     .dw 0x0000
   746C 68 74                93     .dw player_attack_null
                             94 
   746E                      95 player_attack_o::
   746E 00 45                96     .dw _spr_player_attack_05
   7470 00 46                97     .dw _spr_player_attack_06
   7472 00 47                98     .dw _spr_player_attack_07
   7474 00 48                99     .dw _spr_player_attack_08
   7476 00 49               100     .dw _spr_player_attack_09
   7478 00 00               101     .dw 0x0000
   747A 68 74               102     .dw player_attack_null
                            103 
   747C                     104 player_attack_p::
   747C 00 4A               105     .dw _spr_player_attack_10
   747E 00 4B               106     .dw _spr_player_attack_11
   7480 00 4C               107     .dw _spr_player_attack_12
   7482 00 4D               108     .dw _spr_player_attack_13
   7484 00 4E               109     .dw _spr_player_attack_14
   7486 00 00               110     .dw 0x0000
   7488 68 74               111     .dw player_attack_null
                            112 
                            113 
                            114 ;; -------------- FUNCTIONS --------------
                            115 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            116 ;; allows to update an animation choosing the updating speed
                            117 ;; Input:
                            118 ;;      B = updating speed (1, 3, 7 ...)
   748A                     119 sys_animation_update_custom_speed::
   748A 3A 5E 73      [13]  120     ld      a, (frame_counter)
   748D A0            [ 4]  121     and     b
   748E C0            [11]  122     ret     nz
   748F 18 06         [12]  123     jr      sys_animation_update_fast
                            124     
                            125 ;; Input:
                            126 ;;      IX = entity to update its animation
   7491                     127 sys_animation_update::
                            128 
   7491 3A 5E 73      [13]  129     ld      a, (frame_counter)
   7494 E6 0F         [ 7]  130     and     #animation_speed
   7496 C0            [11]  131     ret     nz
                            132 
                            133 ;; updates the animation at real speed
                            134 ;; Input:
                            135 ;;      IX = entity to update its animation
   7497                     136 sys_animation_update_fast::
                            137     ;; Increments anim_counter
   7497 DD 7E 0C      [19]  138     ld a, e_anim_counter(ix)
   749A 3C            [ 4]  139     inc a
   749B DD 77 0C      [19]  140     ld e_anim_counter(ix), a
                            141 
                            142     ;; Saves animation in hl
   749E DD 6E 08      [19]  143     ld l, e_anim(ix)
   74A1 DD 66 09      [19]  144     ld h, e_anim+1(ix)
   74A4 87            [ 4]  145     add a
   74A5 85            [ 4]  146     add l
   74A6 30 01         [12]  147     jr nc, _no_carry
   74A8 24            [ 4]  148     inc h
   74A9                     149  _no_carry:
   74A9 6F            [ 4]  150     ld l, a
                            151     ;; Saves the next sprite in DE
   74AA 5E            [ 7]  152     ld e, (hl)
   74AB 23            [ 6]  153     inc hl
   74AC 56            [ 7]  154     ld d, (hl)
                            155 
                            156     ;; --Checks end of animation--
   74AD 7A            [ 4]  157     ld a, d
   74AE FE 00         [ 7]  158     cp #0
   74B0 20 14         [12]  159     jr nz, _next_sprite
                            160 
                            161     ;; checks type of animation
                            162     ;; execute function or not
   74B2 7B            [ 4]  163     ld a, e
   74B3 FE 00         [ 7]  164     cp #0
   74B5 28 16         [12]  165     jr z, _end_of_animation
   74B7 7B            [ 4]  166     ld a, e
   74B8 FE 01         [ 7]  167     cp #1
   74BA 28 1B         [12]  168     jr z, _execute_function
                            169 
   74BC                     170  _next_anim:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            171     ;; de -> next anim pointer
   74BC DD 73 08      [19]  172     ld e_anim  (ix), e
   74BF DD 72 09      [19]  173     ld e_anim+1(ix), d
   74C2 EB            [ 4]  174     ex de, hl
   74C3 5E            [ 7]  175     ld e, (hl)
   74C4 23            [ 6]  176     inc hl
   74C5 56            [ 7]  177     ld d, (hl)
                            178     ;; de -> next sprite
   74C6                     179  _next_sprite:
   74C6 DD 73 04      [19]  180     ld e_sprite  (ix), e
   74C9 DD 72 05      [19]  181     ld e_sprite+1(ix), d
   74CC C9            [10]  182     ret
                            183 
   74CD                     184  _end_of_animation:
   74CD DD 36 0C 00   [19]  185     ld e_anim_counter(ix), #0
   74D1 23            [ 6]  186     inc hl
                            187 
                            188     ;; hl -> next anim pointer
   74D2 5E            [ 7]  189     ld e, (hl)
   74D3 23            [ 6]  190     inc hl
   74D4 56            [ 7]  191     ld d, (hl)
                            192 
                            193     ; ex de, hl
                            194 
                            195     ; ;; hl -> next anim
                            196     ; ld e, (hl)
                            197     ; inc hl
                            198     ; ld d, (hl)
                            199 
   74D5 18 E5         [12]  200     jr _next_anim
                            201 
   74D7                     202  _execute_function:
   74D7 23            [ 6]  203     inc hl
   74D8 5E            [ 7]  204     ld e, (hl)
   74D9 23            [ 6]  205     inc hl
   74DA 56            [ 7]  206     ld d, (hl)
   74DB EB            [ 4]  207     ex de, hl
                            208     
   74DC 22 E0 74      [16]  209     ld (_func), hl
                     00E3   210     _func = .+1
   74DF CD E0 74      [17]  211     call (_func)
                            212 
   74E2 EB            [ 4]  213     ex  de, hl ;;; TODO: comprobar estado de HL y DE
                            214 
   74E3 18 E8         [12]  215     jr _end_of_animation
                            216 
                            217 
                            218 
                            219 ;; ------------------------------
                            220 
   74E5                     221 move_player::
   74E5 3A FD 73      [13]  222     ld      a, (target_player_position)
   74E8 DD 77 03      [19]  223     ld      e_y(ix), a
                            224 
   74EB 01 10 00      [10]  225     ld      bc, #size_of_tmpl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   74EE DD 09         [15]  226     add     ix, bc
   74F0 DD 77 03      [19]  227     ld      e_y (ix), a ;; move the player attack
                            228     ; ld      e_sprite (ix), #_spr_player_attack_04 ;; change sprite to erase the attack
                            229     ; call    sys_render_update
   74F3 01 F0 FF      [10]  230     ld      bc, #-size_of_tmpl
   74F6 DD 09         [15]  231     add     ix, bc
                            232 
   74F8 C9            [10]  233     ret 
                            234 

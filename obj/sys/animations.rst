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
                     0013    66 next_entity_y   = e_y+16 ;; size_of_tmpl
                             67 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              3 .include "man/game.h.s"
                              1 .globl frame_counter
                              2 .globl sys_game_init
                              3 .globl sys_game_play
                              4 
                              5 .globl sys_game_inc_frames_counter
                              6 .globl sys_game_inc_points
                              7 .globl sys_game_dec_points
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              4 
                     000F     5 animation_speed = 15
                              6 
   73B1                       7 target_player_position::
   73B1 32                    8     .db #LANE1_Y_PLAYER
                              9 
   73B2                      10 enemy_null_anim:
   73B2 40 6C                11     .dw _spr_alien_void_5 
   73B4 00 00                12     .dw 0x0000
   73B6 B2 73                13     .dw enemy_null_anim
                             14 
   73B8                      15 enemy_void_death_anim::
   73B8 C0 69                16     .dw _spr_alien_void_3 
   73BA 00 6B                17     .dw _spr_alien_void_4 
   73BC 40 6C                18     .dw _spr_alien_void_5 
   73BE 01 00                19     .dw 0x0001
   73C0 A4 72                20     .dw man_enemy_set4destruction
   73C2 B2 73                21     .dw enemy_null_anim
                             22 
   73C4                      23 enemy_o_death_anim::
   73C4 40 62                24     .dw _spr_alien_o_3 
   73C6 80 63                25     .dw _spr_alien_o_4 
   73C8 C0 64                26     .dw _spr_alien_o_5 
   73CA 01 00                27     .dw 0x0001
   73CC A4 72                28     .dw man_enemy_set4destruction
   73CE B2 73                29     .dw enemy_null_anim
                             30 
   73D0                      31 enemy_p_death_anim::
   73D0 C0 5A                32     .dw _spr_alien_p_3 
   73D2 00 5C                33     .dw _spr_alien_p_4 
   73D4 40 5D                34     .dw _spr_alien_p_5 
   73D6 01 00                35     .dw 0x0001
   73D8 A4 72                36     .dw man_enemy_set4destruction
   73DA B2 73                37     .dw enemy_null_anim
                             38 
   73DC                      39 enemy_void_anim::
   73DC 00 66                40     .dw _spr_alien_void_0
   73DE 40 67                41     .dw _spr_alien_void_1
   73E0 80 68                42     .dw _spr_alien_void_2
   73E2 00 00                43     .dw 0x0000
   73E4 DC 73                44     .dw enemy_void_anim
                             45 
   73E6                      46 enemy_o_anim::
   73E6 80 5E                47     .dw _spr_alien_o_0
   73E8 C0 5F                48     .dw _spr_alien_o_1
   73EA 00 61                49     .dw _spr_alien_o_2
   73EC 00 00                50     .dw 0x0000
   73EE E6 73                51     .dw enemy_o_anim
                             52 
   73F0                      53 enemy_p_anim::
   73F0 00 57                54     .dw _spr_alien_p_0
   73F2 40 58                55     .dw _spr_alien_p_1
   73F4 80 59                56     .dw _spr_alien_p_2
   73F6 00 00                57     .dw 0x0000
   73F8 F0 73                58     .dw enemy_p_anim
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             59 
   73FA                      60 player_standby_anim::
   73FA 00 55                61     .dw _spr_player_0
   73FC 00 56                62     .dw _spr_player_1
   73FE 00 00                63     .dw 0x0000
   7400 FA 73                64     .dw player_standby_anim
                             65 
   7402                      66 player_tp_anim::
   7402 00 4F                67     .dw _spr_player_tp_0
   7404 00 50                68     .dw _spr_player_tp_1
                             69     ;.dw _spr_player_tp_2
   7406 00 52                70     .dw _spr_player_tp_3
                             71     ;.dw _spr_player_tp_4
   7408 00 54                72     .dw _spr_player_tp_5
   740A 01 00                73     .dw 0x0001
   740C 99 74                74     .dw move_player
   740E 10 74                75     .dw player_tp_mirror_anim
                             76 
   7410                      77 player_tp_mirror_anim::
   7410 00 54                78     .dw _spr_player_tp_5
                             79     ;.dw _spr_player_tp_4
   7412 00 52                80     .dw _spr_player_tp_3
                             81     ;.dw _spr_player_tp_2
   7414 00 50                82     .dw _spr_player_tp_1
   7416 00 4F                83     .dw _spr_player_tp_0
   7418 00 00                84     .dw 0x0000
   741A FA 73                85     .dw player_standby_anim
                             86 
                             87 
   741C                      88 player_attack_null::
   741C 00 49                89     .dw _spr_player_attack_09
   741E 00 00                90     .dw 0x0000
   7420 1C 74                91     .dw player_attack_null
                             92 
   7422                      93 player_attack_o::
   7422 00 45                94     .dw _spr_player_attack_05
   7424 00 46                95     .dw _spr_player_attack_06
   7426 00 47                96     .dw _spr_player_attack_07
   7428 00 48                97     .dw _spr_player_attack_08
   742A 00 49                98     .dw _spr_player_attack_09
   742C 00 00                99     .dw 0x0000
   742E 1C 74               100     .dw player_attack_null
                            101 
   7430                     102 player_attack_p::
   7430 00 4A               103     .dw _spr_player_attack_10
   7432 00 4B               104     .dw _spr_player_attack_11
   7434 00 4C               105     .dw _spr_player_attack_12
   7436 00 4D               106     .dw _spr_player_attack_13
   7438 00 4E               107     .dw _spr_player_attack_14
   743A 00 00               108     .dw 0x0000
   743C 1C 74               109     .dw player_attack_null
                            110 
                            111 
                            112 ;; -------------- FUNCTIONS --------------
                            113 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            114 ;; allows to update an animation choosing the updating speed
                            115 ;; Input:
                            116 ;;      B = updating speed (1, 3, 7 ...)
   743E                     117 sys_animation_update_custom_speed::
   743E 3A 53 73      [13]  118     ld      a, (frame_counter)
   7441 A0            [ 4]  119     and     b
   7442 C0            [11]  120     ret     nz
   7443 18 06         [12]  121     jr      sys_animation_update_fast
                            122     
                            123 ;; Input:
                            124 ;;      IX = entity to update its animation
   7445                     125 sys_animation_update::
                            126 
   7445 3A 53 73      [13]  127     ld      a, (frame_counter)
   7448 E6 0F         [ 7]  128     and     #animation_speed
   744A C0            [11]  129     ret     nz
                            130 
                            131 ;; updates the animation at real speed
                            132 ;; Input:
                            133 ;;      IX = entity to update its animation
   744B                     134 sys_animation_update_fast::
                            135     ;; Increments anim_counter
   744B DD 7E 0C      [19]  136     ld a, e_anim_counter(ix)
   744E 3C            [ 4]  137     inc a
   744F DD 77 0C      [19]  138     ld e_anim_counter(ix), a
                            139 
                            140     ;; Saves animation in hl
   7452 DD 6E 08      [19]  141     ld l, e_anim(ix)
   7455 DD 66 09      [19]  142     ld h, e_anim+1(ix)
   7458 87            [ 4]  143     add a
   7459 85            [ 4]  144     add l
   745A 30 01         [12]  145     jr nc, _no_carry
   745C 24            [ 4]  146     inc h
   745D                     147  _no_carry:
   745D 6F            [ 4]  148     ld l, a
                            149     ;; Saves the next sprite in DE
   745E 5E            [ 7]  150     ld e, (hl)
   745F 23            [ 6]  151     inc hl
   7460 56            [ 7]  152     ld d, (hl)
                            153 
                            154     ;; --Checks end of animation--
   7461 7A            [ 4]  155     ld a, d
   7462 FE 00         [ 7]  156     cp #0
   7464 20 14         [12]  157     jr nz, _next_sprite
                            158 
                            159     ;; checks type of animation
                            160     ;; execute function or not
   7466 7B            [ 4]  161     ld a, e
   7467 FE 00         [ 7]  162     cp #0
   7469 28 16         [12]  163     jr z, _end_of_animation
   746B 7B            [ 4]  164     ld a, e
   746C FE 01         [ 7]  165     cp #1
   746E 28 1B         [12]  166     jr z, _execute_function
                            167 
   7470                     168  _next_anim:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            169     ;; de -> next anim pointer
   7470 DD 73 08      [19]  170     ld e_anim  (ix), e
   7473 DD 72 09      [19]  171     ld e_anim+1(ix), d
   7476 EB            [ 4]  172     ex de, hl
   7477 5E            [ 7]  173     ld e, (hl)
   7478 23            [ 6]  174     inc hl
   7479 56            [ 7]  175     ld d, (hl)
                            176     ;; de -> next sprite
   747A                     177  _next_sprite:
   747A DD 73 04      [19]  178     ld e_sprite  (ix), e
   747D DD 72 05      [19]  179     ld e_sprite+1(ix), d
   7480 C9            [10]  180     ret
                            181 
   7481                     182  _end_of_animation:
   7481 DD 36 0C 00   [19]  183     ld e_anim_counter(ix), #0
   7485 23            [ 6]  184     inc hl
                            185 
                            186     ;; hl -> next anim pointer
   7486 5E            [ 7]  187     ld e, (hl)
   7487 23            [ 6]  188     inc hl
   7488 56            [ 7]  189     ld d, (hl)
                            190 
                            191     ; ex de, hl
                            192 
                            193     ; ;; hl -> next anim
                            194     ; ld e, (hl)
                            195     ; inc hl
                            196     ; ld d, (hl)
                            197 
   7489 18 E5         [12]  198     jr _next_anim
                            199 
   748B                     200  _execute_function:
   748B 23            [ 6]  201     inc hl
   748C 5E            [ 7]  202     ld e, (hl)
   748D 23            [ 6]  203     inc hl
   748E 56            [ 7]  204     ld d, (hl)
   748F EB            [ 4]  205     ex de, hl
                            206     
   7490 22 94 74      [16]  207     ld (_func), hl
                     00E3   208     _func = .+1
   7493 CD 94 74      [17]  209     call (_func)
                            210 
   7496 EB            [ 4]  211     ex  de, hl ;;; TODO: comprobar estado de HL y DE
                            212 
   7497 18 E8         [12]  213     jr _end_of_animation
                            214 
                            215 
                            216 
                            217 ;; ------------------------------
                            218 
   7499                     219 move_player::
                            220     
   7499 3A B1 73      [13]  221     ld a, (target_player_position)
   749C DD 77 03      [19]  222     ld e_y(ix), a
   749F DD 77 13      [19]  223     ld next_entity_y (ix), a ;; move the player attack (is in the next position)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   74A2 C9            [10]  224     ret 
                            225 

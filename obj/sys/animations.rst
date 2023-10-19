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
                             59 .globl target_player_position
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
   73A8                       7 target_player_position::
   73A8 32                    8     .db #LANE1_Y_PLAYER
                              9 
   73A9                      10 enemy_null_anim:
   73A9 40 6C                11     .dw _spr_alien_void_5 
   73AB 00 00                12     .dw 0x0000
   73AD A9 73                13     .dw enemy_null_anim
                             14 
   73AF                      15 enemy_void_death_anim::
   73AF C0 69                16     .dw _spr_alien_void_3 
   73B1 00 6B                17     .dw _spr_alien_void_4 
   73B3 40 6C                18     .dw _spr_alien_void_5 
   73B5 01 00                19     .dw 0x0001
   73B7 A4 72                20     .dw man_enemy_set4destruction
   73B9 A9 73                21     .dw enemy_null_anim
                             22 
   73BB                      23 enemy_o_death_anim::
   73BB 40 62                24     .dw _spr_alien_o_3 
   73BD 80 63                25     .dw _spr_alien_o_4 
   73BF C0 64                26     .dw _spr_alien_o_5 
   73C1 01 00                27     .dw 0x0001
   73C3 A4 72                28     .dw man_enemy_set4destruction
   73C5 A9 73                29     .dw enemy_null_anim
                             30 
   73C7                      31 enemy_p_death_anim::
   73C7 C0 5A                32     .dw _spr_alien_p_3 
   73C9 00 5C                33     .dw _spr_alien_p_4 
   73CB 40 5D                34     .dw _spr_alien_p_5 
   73CD 01 00                35     .dw 0x0001
   73CF A4 72                36     .dw man_enemy_set4destruction
   73D1 A9 73                37     .dw enemy_null_anim
                             38 
   73D3                      39 enemy_void_anim::
   73D3 00 66                40     .dw _spr_alien_void_0
   73D5 40 67                41     .dw _spr_alien_void_1
   73D7 80 68                42     .dw _spr_alien_void_2
   73D9 00 00                43     .dw 0x0000
   73DB D3 73                44     .dw enemy_void_anim
                             45 
   73DD                      46 enemy_o_anim::
   73DD 80 5E                47     .dw _spr_alien_o_0
   73DF C0 5F                48     .dw _spr_alien_o_1
   73E1 00 61                49     .dw _spr_alien_o_2
   73E3 00 00                50     .dw 0x0000
   73E5 DD 73                51     .dw enemy_o_anim
                             52 
   73E7                      53 enemy_p_anim::
   73E7 00 57                54     .dw _spr_alien_p_0
   73E9 40 58                55     .dw _spr_alien_p_1
   73EB 80 59                56     .dw _spr_alien_p_2
   73ED 00 00                57     .dw 0x0000
   73EF E7 73                58     .dw enemy_p_anim
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             59 
   73F1                      60 player_standby_anim::
   73F1 00 55                61     .dw _spr_player_0
   73F3 00 56                62     .dw _spr_player_1
   73F5 00 00                63     .dw 0x0000
   73F7 F1 73                64     .dw player_standby_anim
                             65 
   73F9                      66 player_tp_anim::
   73F9 00 4F                67     .dw _spr_player_tp_0
   73FB 00 50                68     .dw _spr_player_tp_1
                             69     ;.dw _spr_player_tp_2
   73FD 00 52                70     .dw _spr_player_tp_3
                             71     ;.dw _spr_player_tp_4
   73FF 00 54                72     .dw _spr_player_tp_5
   7401 01 00                73     .dw 0x0001
   7403 89 74                74     .dw move_player
   7405 07 74                75     .dw player_tp_mirror_anim
                             76 
   7407                      77 player_tp_mirror_anim::
   7407 00 54                78     .dw _spr_player_tp_5
                             79     ;.dw _spr_player_tp_4
   7409 00 52                80     .dw _spr_player_tp_3
                             81     ;.dw _spr_player_tp_2
   740B 00 50                82     .dw _spr_player_tp_1
   740D 00 4F                83     .dw _spr_player_tp_0
   740F 00 00                84     .dw 0x0000
   7411 F1 73                85     .dw player_standby_anim
                             86 
                             87 
   7413                      88 player_attack_null::
   7413 00 49                89     .dw _spr_player_attack_09
   7415 00 00                90     .dw 0x0000
   7417 13 74                91     .dw player_attack_null
                             92 
   7419                      93 player_attack_o::
   7419 00 45                94     .dw _spr_player_attack_05
   741B 00 46                95     .dw _spr_player_attack_06
   741D 00 47                96     .dw _spr_player_attack_07
   741F 00 48                97     .dw _spr_player_attack_08
   7421 00 49                98     .dw _spr_player_attack_09
   7423 00 00                99     .dw 0x0000
   7425 13 74               100     .dw player_attack_null
                            101 
   7427                     102 player_attack_p::
   7427 00 4A               103     .dw _spr_player_attack_10
   7429 00 4B               104     .dw _spr_player_attack_11
   742B 00 4C               105     .dw _spr_player_attack_12
   742D 00 4D               106     .dw _spr_player_attack_13
   742F 00 4E               107     .dw _spr_player_attack_14
   7431 00 00               108     .dw 0x0000
   7433 13 74               109     .dw player_attack_null
                            110 
                            111 
                            112 ;; ----------------------------- :D
                            113 ;; Input:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            114 ;;      IX = entity to update its animation
   7435                     115 sys_animation_update::
                            116 
   7435 3A 53 73      [13]  117     ld      a, (frame_counter)
   7438 E6 0F         [ 7]  118     and     #animation_speed
   743A C0            [11]  119     ret nz
                            120 
                            121     ; ld ix, #player
                            122 
                            123     ;; Increments anim_counter
   743B DD 7E 0C      [19]  124     ld a, e_anim_counter(ix)
   743E 3C            [ 4]  125     inc a
   743F DD 77 0C      [19]  126     ld e_anim_counter(ix), a
                            127 
                            128     ;; Saves animation in hl
   7442 DD 6E 08      [19]  129     ld l, e_anim(ix)
   7445 DD 66 09      [19]  130     ld h, e_anim+1(ix)
   7448 87            [ 4]  131     add a
   7449 85            [ 4]  132     add l
   744A 30 01         [12]  133     jr nc, _no_carry
   744C 24            [ 4]  134     inc h
   744D                     135  _no_carry:
   744D 6F            [ 4]  136     ld l, a
                            137     ;; Saves the next sprite in DE
   744E 5E            [ 7]  138     ld e, (hl)
   744F 23            [ 6]  139     inc hl
   7450 56            [ 7]  140     ld d, (hl)
                            141 
                            142     ;; --Checks end of animation--
   7451 7A            [ 4]  143     ld a, d
   7452 FE 00         [ 7]  144     cp #0
   7454 20 14         [12]  145     jr nz, _next_sprite
                            146 
                            147     ;; checks type of animation
                            148     ;; execute function or not
   7456 7B            [ 4]  149     ld a, e
   7457 FE 00         [ 7]  150     cp #0
   7459 28 16         [12]  151     jr z, _end_of_animation
   745B 7B            [ 4]  152     ld a, e
   745C FE 01         [ 7]  153     cp #1
   745E 28 1B         [12]  154     jr z, _execute_function
                            155 
   7460                     156  _next_anim:
                            157     ;; de -> next anim pointer
   7460 DD 73 08      [19]  158     ld e_anim  (ix), e
   7463 DD 72 09      [19]  159     ld e_anim+1(ix), d
   7466 EB            [ 4]  160     ex de, hl
   7467 5E            [ 7]  161     ld e, (hl)
   7468 23            [ 6]  162     inc hl
   7469 56            [ 7]  163     ld d, (hl)
                            164     ;; de -> next sprite
   746A                     165  _next_sprite:
   746A DD 73 04      [19]  166     ld e_sprite  (ix), e
   746D DD 72 05      [19]  167     ld e_sprite+1(ix), d
   7470 C9            [10]  168     ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            169 
   7471                     170  _end_of_animation:
   7471 DD 36 0C 00   [19]  171     ld e_anim_counter(ix), #0
   7475 23            [ 6]  172     inc hl
                            173 
                            174     ;; hl -> next anim pointer
   7476 5E            [ 7]  175     ld e, (hl)
   7477 23            [ 6]  176     inc hl
   7478 56            [ 7]  177     ld d, (hl)
                            178 
                            179     ; ex de, hl
                            180 
                            181     ; ;; hl -> next anim
                            182     ; ld e, (hl)
                            183     ; inc hl
                            184     ; ld d, (hl)
                            185 
   7479 18 E5         [12]  186     jr _next_anim
                            187 
   747B                     188  _execute_function:
   747B 23            [ 6]  189     inc hl
   747C 5E            [ 7]  190     ld e, (hl)
   747D 23            [ 6]  191     inc hl
   747E 56            [ 7]  192     ld d, (hl)
   747F EB            [ 4]  193     ex de, hl
                            194     
   7480 22 84 74      [16]  195     ld (_func), hl
                     00DC   196     _func = .+1
   7483 CD 84 74      [17]  197     call (_func)
                            198 
   7486 EB            [ 4]  199     ex  de, hl ;;; TODO: comprobar estado de HL y DE
                            200 
   7487 18 E8         [12]  201     jr _end_of_animation
                            202 
                            203 
                            204 
                            205 ;; ------------------------------
                            206 
   7489                     207 move_player::
                            208     
   7489 3A A8 73      [13]  209     ld a, (target_player_position)
   748C DD 77 03      [19]  210     ld e_y(ix), a
   748F DD 77 13      [19]  211     ld next_entity_y (ix), a ;; move the player attack (is in the next position)
   7492 C9            [10]  212     ret 
                            213 

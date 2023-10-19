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
                             22 
                             23 .globl _spr_player_0
                             24 .globl _spr_player_1
                             25 .globl _spr_player_tp_0
                             26 .globl _spr_player_tp_1
                             27 .globl _spr_player_tp_2
                             28 .globl _spr_player_tp_3
                             29 .globl _spr_player_tp_4
                             30 .globl _spr_player_tp_5
                             31 
                             32 
                             33 .globl enemy_void_anim
                             34 .globl enemy_o_anim
                             35 .globl enemy_p_anim
                             36 .globl player_standby_anim
                             37 .globl player_tp_anim
                             38 .globl player_tp_mirror_anim
                             39 .globl enemy_death_anim
                             40 
                             41 .globl sys_animation_update
                             42 
                             43 .globl target_player_position
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
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
                     0032    37 LANE1_Y_PLAYER = LANE1_Y ;; / 16x16 enemy sprites -> LANE1_Y-8
                     0078    38 LANE2_Y_PLAYER = LANE2_Y ;; \ 16x32 enemy sprites -> LANE1_Y
                             39 
                     0006    40 POS_X_PLAYER = 6
                     0045    41 INIT_X_ENEMY = 69 ;; 79 (end of screen) - 10 (width of sprite)
                             42 
                     0014    43 TRIGGER_LENGTH = 20 ;; TODO: hay que hacer pruebas a ver cuál es la mejor distancia
                     001A    44 KILLING_ENEMIES_POS = POS_X_PLAYER + TRIGGER_LENGTH
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                     0006    55 e_ia = 6
                     0008    56 e_anim = 8
                     000A    57 e_anim_counter = 10
                     000B    58 e_collides = 11
                             59 
                     000C    60 e_h = 12
                     000D    61 e_w = 13
                             62 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              3 .include "man/game.h.s"
                              1 .globl frame_counter
                              2 .globl sys_game_init
                              3 .globl sys_game_play
                              4 
                              5 .globl sys_game_inc_frames_counter
                              6 .globl sys_game_inc_points
                              7 .globl sys_game_dec_points
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              4 
                     000F     5 animation_speed = 15
                              6 
   735A                       7 target_player_position::
   735A 32                    8     .db #LANE1_Y_PLAYER
                              9 
   735B                      10 enemy_death_anim::
   735B 40 6C                11     .dw _spr_alien_void_5 ;;TODO: se muestra otro sprite
   735D 01 00                12     .dw 0x0001
   735F 74 72                13     .dw man_enemy_set4destruction
   7361 63 73                14     .dw enemy_void_anim
                             15 
   7363                      16 enemy_void_anim::
   7363 00 66                17     .dw _spr_alien_void_0
   7365 40 67                18     .dw _spr_alien_void_1
   7367 80 68                19     .dw _spr_alien_void_2
   7369 00 00                20     .dw 0x0000
   736B 63 73                21     .dw enemy_void_anim
                             22 
   736D                      23 enemy_o_anim::
   736D 80 5E                24     .dw _spr_alien_o_0
   736F C0 5F                25     .dw _spr_alien_o_1
   7371 00 61                26     .dw _spr_alien_o_2
   7373 00 00                27     .dw 0x0000
   7375 6D 73                28     .dw enemy_o_anim
                             29 
   7377                      30 enemy_p_anim::
   7377 00 57                31     .dw _spr_alien_p_0
   7379 40 58                32     .dw _spr_alien_p_1
   737B 80 59                33     .dw _spr_alien_p_2
   737D 00 00                34     .dw 0x0000
   737F 77 73                35     .dw enemy_p_anim
                             36 
   7381                      37 player_standby_anim::
   7381 00 55                38     .dw _spr_player_0
   7383 00 56                39     .dw _spr_player_1
   7385 00 00                40     .dw 0x0000
   7387 81 73                41     .dw player_standby_anim
                             42 
   7389                      43 player_tp_anim::
   7389 00 4F                44     .dw _spr_player_tp_0
   738B 00 50                45     .dw _spr_player_tp_1
                             46     ;.dw _spr_player_tp_2
   738D 00 52                47     .dw _spr_player_tp_3
                             48     ;.dw _spr_player_tp_4
   738F 00 54                49     .dw _spr_player_tp_5
   7391 01 00                50     .dw 0x0001
   7393 F7 73                51     .dw move_player
   7395 97 73                52     .dw player_tp_mirror_anim
                             53 
   7397                      54 player_tp_mirror_anim::
   7397 00 54                55     .dw _spr_player_tp_5
                             56     ;.dw _spr_player_tp_4
   7399 00 52                57     .dw _spr_player_tp_3
                             58     ;.dw _spr_player_tp_2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   739B 00 50                59     .dw _spr_player_tp_1
   739D 00 4F                60     .dw _spr_player_tp_0
   739F 00 00                61     .dw 0x0000
   73A1 81 73                62     .dw player_standby_anim
                             63 
                             64 
                             65 ;; ----------------------------- :D
                             66 ;; Input:
                             67 ;;      IX = entity to update its animation
   73A3                      68 sys_animation_update::
                             69 
   73A3 3A 08 73      [13]   70     ld      a, (frame_counter)
   73A6 E6 0F         [ 7]   71     and     #animation_speed
   73A8 C0            [11]   72     ret nz
                             73 
                             74     ; ld ix, #player
                             75 
                             76     ;; Increments anim_counter
   73A9 DD 7E 0A      [19]   77     ld a, e_anim_counter(ix)
   73AC 3C            [ 4]   78     inc a
   73AD DD 77 0A      [19]   79     ld e_anim_counter(ix), a
                             80 
                             81     ;; Saves animation in hl
   73B0 DD 6E 08      [19]   82     ld l, e_anim(ix)
   73B3 DD 66 09      [19]   83     ld h, e_anim+1(ix)
   73B6 87            [ 4]   84     add a
   73B7 85            [ 4]   85     add l
   73B8 30 01         [12]   86     jr nc, _no_carry
   73BA 24            [ 4]   87     inc h
   73BB                      88  _no_carry:
   73BB 6F            [ 4]   89     ld l, a
                             90     ;; Saves the next sprite in DE
   73BC 5E            [ 7]   91     ld e, (hl)
   73BD 23            [ 6]   92     inc hl
   73BE 56            [ 7]   93     ld d, (hl)
                             94 
                             95     ;; --Checks end of animation--
   73BF 7A            [ 4]   96     ld a, d
   73C0 FE 00         [ 7]   97     cp #0
   73C2 20 14         [12]   98     jr nz, _next_sprite
                             99 
                            100     ;; checks type of animation
                            101     ;; execute function or not
   73C4 7B            [ 4]  102     ld a, e
   73C5 FE 00         [ 7]  103     cp #0
   73C7 28 16         [12]  104     jr z, _end_of_animation
   73C9 7B            [ 4]  105     ld a, e
   73CA FE 01         [ 7]  106     cp #1
   73CC 28 1B         [12]  107     jr z, _execute_function
                            108 
   73CE                     109  _next_anim:
                            110     ;; de -> next anim pointer
   73CE DD 73 08      [19]  111     ld e_anim  (ix), e
   73D1 DD 72 09      [19]  112     ld e_anim+1(ix), d
   73D4 EB            [ 4]  113     ex de, hl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   73D5 5E            [ 7]  114     ld e, (hl)
   73D6 23            [ 6]  115     inc hl
   73D7 56            [ 7]  116     ld d, (hl)
                            117     ;; de -> next sprite
   73D8                     118  _next_sprite:
   73D8 DD 73 04      [19]  119     ld e_sprite  (ix), e
   73DB DD 72 05      [19]  120     ld e_sprite+1(ix), d
   73DE C9            [10]  121     ret
                            122 
   73DF                     123  _end_of_animation:
   73DF DD 36 0A 00   [19]  124     ld e_anim_counter(ix), #0
   73E3 23            [ 6]  125     inc hl
                            126 
                            127     ;; hl -> next anim pointer
   73E4 5E            [ 7]  128     ld e, (hl)
   73E5 23            [ 6]  129     inc hl
   73E6 56            [ 7]  130     ld d, (hl)
                            131 
                            132     ; ex de, hl
                            133 
                            134     ; ;; hl -> next anim
                            135     ; ld e, (hl)
                            136     ; inc hl
                            137     ; ld d, (hl)
                            138 
   73E7 18 E5         [12]  139     jr _next_anim
                            140 
   73E9                     141  _execute_function:
   73E9 23            [ 6]  142     inc hl
   73EA 5E            [ 7]  143     ld e, (hl)
   73EB 23            [ 6]  144     inc hl
   73EC 56            [ 7]  145     ld d, (hl)
   73ED EB            [ 4]  146     ex de, hl
                            147     
   73EE 22 F2 73      [16]  148     ld (_func), hl
                     0098   149     _func = .+1
   73F1 CD F2 73      [17]  150     call (_func)
                            151 
   73F4 EB            [ 4]  152     ex  de, hl ;;; TODO: comprobar estado de HL y DE
                            153 
   73F5 18 E8         [12]  154     jr _end_of_animation
                            155 
                            156 
                            157 
                            158 ;; ------------------------------
                            159 
   73F7                     160 move_player::
                            161     
   73F7 3A 5A 73      [13]  162     ld a, (target_player_position)
   73FA DD 77 03      [19]  163     ld e_y(ix), a
   73FD C9            [10]  164     ret 
                            165 

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .include "animations.h.s"
                              1 .globl _spr_aliens_0
                              2 .globl _spr_aliens_1
                              3 .globl _spr_aliens_2
                              4 .globl _spr_aliens_3
                              5 .globl _spr_aliens_4
                              6 .globl _spr_aliens_5
                              7 .globl _spr_player_0
                              8 .globl _spr_player_1
                              9 .globl _spr_player_tp_0
                             10 .globl _spr_player_tp_1
                             11 .globl _spr_player_tp_2
                             12 .globl _spr_player_tp_3
                             13 .globl _spr_player_tp_4
                             14 .globl _spr_player_tp_5
                             15 
                             16 
                             17 .globl enemy_void_anim
                             18 .globl enemy_o_anim
                             19 .globl enemy_p_anim
                             20 .globl player_standby_anim
                             21 .globl player_tp_anim
                             22 .globl player_tp_mirror_anim
                             23 
                             24 .globl sys_animation_update
                             25 
                             26 .globl target_player_position
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              2 .include "man/entities.h.s"
                              1 
                              2 .globl man_entity_init
                              3 .globl man_enemy_create
                              4 .globl man_player_create
                              5 .globl man_enemy_set4destruction
                              6 .globl man_enemy_destroy
                              7 .globl man_enemy_forall
                              8 .globl man_enemy_update
                              9 .globl man_entity_forall
                             10 
                             11 .globl enemies_array
                             12 .globl player
                             13 
                     0000    14 type_invalid    =   0
                     0001    15 type_enemy_o    =   1
                     0002    16 type_enemy_p    =   2
                     0003    17 type_enemy_void =   3
                     0004    18 type_player     =   4
                     0005    19 type_trigger    =   5
                             20 
                     0000    21 e_cmp_default   =   0x00
                     0001    22 e_cmp_ia        =   0x01
                     0002    23 e_cmp_movable   =   0x02
                     0004    24 e_cmp_render    =   0x04
                     0008    25 e_cmp_collider  =   0x08
                     0010    26 e_cmp_animated  =   0x10
                     0020    27 e_cmp_input     =   0x20
                     0080    28 e_cmp_dead      =   0x80
                             29 
                             30 
                     0032    31 LANE1_Y = 50
                     0078    32 LANE2_Y = 120
                             33 
                     002A    34 LANE1_Y_PLAYER = LANE1_Y-8
                     0070    35 LANE2_Y_PLAYER = LANE2_Y-8
                             36 
                     000A    37 max_enemies = 10
                             38 
                     0000    39 e_type = 0
                     0001    40 e_comp = 1
                     0002    41 e_x = 2
                     0003    42 e_y = 3
                     0004    43 e_sprite = 4
                     0006    44 e_ia = 6
                     0008    45 e_anim = 8
                     000A    46 e_anim_counter = 10
                     000B    47 e_collides = 11
                             48 
                     000C    49 e_h = 12
                     000D    50 e_w = 13
                             51 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              3 .include "man/game.h.s"
                              1 .globl frame_counter
                              2 .globl sys_game_init
                              3 .globl sys_game_inc_frames_counter
                              4 .globl sys_game_play
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              4 
                     000F     5 animation_speed = 15
                              6 
   4DBE                       7 target_player_position::
   4DBE 2A                    8     .db #LANE1_Y-8
                              9 
   4DBF                      10 enemy_void_anim::
   4DBF 00 48                11     .dw _spr_aliens_0
   4DC1 80 48                12     .dw _spr_aliens_1
   4DC3 00 00                13     .dw 0x0000
   4DC5 BF 4D                14     .dw enemy_void_anim
                             15 
   4DC7                      16 enemy_o_anim::
   4DC7 00 49                17     .dw _spr_aliens_2
   4DC9 80 49                18     .dw _spr_aliens_3
   4DCB 00 00                19     .dw 0x0000
   4DCD C7 4D                20     .dw enemy_o_anim
                             21 
   4DCF                      22 enemy_p_anim::
   4DCF 00 4A                23     .dw _spr_aliens_4
   4DD1 80 4A                24     .dw _spr_aliens_5
   4DD3 00 00                25     .dw 0x0000
   4DD5 CF 4D                26     .dw enemy_p_anim
                             27 
   4DD7                      28 player_standby_anim::
   4DD7 00 46                29     .dw _spr_player_0
   4DD9 00 47                30     .dw _spr_player_1
   4DDB 00 00                31     .dw 0x0000
   4DDD D7 4D                32     .dw player_standby_anim
                             33 
   4DDF                      34 player_tp_anim::
   4DDF 00 40                35     .dw _spr_player_tp_0
   4DE1 00 41                36     .dw _spr_player_tp_1
                             37     ;.dw _spr_player_tp_2
   4DE3 00 43                38     .dw _spr_player_tp_3
                             39     ;.dw _spr_player_tp_4
   4DE5 00 45                40     .dw _spr_player_tp_5
   4DE7 01 00                41     .dw 0x0001
   4DE9 4D 4E                42     .dw move_player
   4DEB ED 4D                43     .dw player_tp_mirror_anim
                             44 
   4DED                      45 player_tp_mirror_anim::
   4DED 00 45                46     .dw _spr_player_tp_5
                             47     ;.dw _spr_player_tp_4
   4DEF 00 43                48     .dw _spr_player_tp_3
                             49     ;.dw _spr_player_tp_2
   4DF1 00 41                50     .dw _spr_player_tp_1
   4DF3 00 40                51     .dw _spr_player_tp_0
   4DF5 00 00                52     .dw 0x0000
   4DF7 D7 4D                53     .dw player_standby_anim
                             54 
                             55 
                             56 ;; ----------------------------- :D
                             57 ;; Input:
                             58 ;;      IX = entity to update its animation
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   4DF9                      59 sys_animation_update::
                             60 
   4DF9 3A 96 4D      [13]   61     ld      a, (frame_counter)
   4DFC E6 0F         [ 7]   62     and     #animation_speed
   4DFE C0            [11]   63     ret nz
                             64 
                             65     ; ld ix, #player
                             66 
                             67     ;; Increments anim_counter
   4DFF DD 7E 0A      [19]   68     ld a, e_anim_counter(ix)
   4E02 3C            [ 4]   69     inc a
   4E03 DD 77 0A      [19]   70     ld e_anim_counter(ix), a
                             71 
                             72     ;; Saves animation in hl
   4E06 DD 6E 08      [19]   73     ld l, e_anim(ix)
   4E09 DD 66 09      [19]   74     ld h, e_anim+1(ix)
   4E0C 87            [ 4]   75     add a
   4E0D 85            [ 4]   76     add l
   4E0E 30 01         [12]   77     jr nc, _no_carry
   4E10 24            [ 4]   78     inc h
   4E11                      79  _no_carry:
   4E11 6F            [ 4]   80     ld l, a
                             81     ;; Saves the next sprite in DE
   4E12 5E            [ 7]   82     ld e, (hl)
   4E13 23            [ 6]   83     inc hl
   4E14 56            [ 7]   84     ld d, (hl)
                             85 
                             86     ;; --Checks end of animation--
   4E15 7A            [ 4]   87     ld a, d
   4E16 FE 00         [ 7]   88     cp #0
   4E18 20 14         [12]   89     jr nz, _next_sprite
                             90 
                             91     ;; checks type of animation
                             92     ;; execute function or not
   4E1A 7B            [ 4]   93     ld a, e
   4E1B FE 00         [ 7]   94     cp #0
   4E1D 28 16         [12]   95     jr z, _end_of_animation
   4E1F 7B            [ 4]   96     ld a, e
   4E20 FE 01         [ 7]   97     cp #1
   4E22 28 1B         [12]   98     jr z, _execute_function
                             99 
   4E24                     100  _next_anim:
                            101     ;; de -> next anim pointer
   4E24 DD 73 08      [19]  102     ld e_anim  (ix), e
   4E27 DD 72 09      [19]  103     ld e_anim+1(ix), d
   4E2A EB            [ 4]  104     ex de, hl
   4E2B 5E            [ 7]  105     ld e, (hl)
   4E2C 23            [ 6]  106     inc hl
   4E2D 56            [ 7]  107     ld d, (hl)
                            108     ;; de -> next sprite
   4E2E                     109  _next_sprite:
   4E2E DD 73 04      [19]  110     ld e_sprite  (ix), e
   4E31 DD 72 05      [19]  111     ld e_sprite+1(ix), d
   4E34 C9            [10]  112     ret
                            113 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   4E35                     114  _end_of_animation:
   4E35 DD 36 0A 00   [19]  115     ld e_anim_counter(ix), #0
   4E39 23            [ 6]  116     inc hl
                            117 
                            118     ;; hl -> next anim pointer
   4E3A 5E            [ 7]  119     ld e, (hl)
   4E3B 23            [ 6]  120     inc hl
   4E3C 56            [ 7]  121     ld d, (hl)
                            122 
                            123     ; ex de, hl
                            124 
                            125     ; ;; hl -> next anim
                            126     ; ld e, (hl)
                            127     ; inc hl
                            128     ; ld d, (hl)
                            129 
   4E3D 18 E5         [12]  130     jr _next_anim
                            131 
   4E3F                     132  _execute_function:
   4E3F 23            [ 6]  133     inc hl
   4E40 5E            [ 7]  134     ld e, (hl)
   4E41 23            [ 6]  135     inc hl
   4E42 56            [ 7]  136     ld d, (hl)
   4E43 EB            [ 4]  137     ex de, hl
                            138     
   4E44 22 48 4E      [16]  139     ld (_func), hl
                     008A   140     _func = .+1
   4E47 CD 48 4E      [17]  141     call (_func)
                            142 
   4E4A EB            [ 4]  143     ex  de, hl ;;; TODO: comprobar estado de HL y DE
                            144 
   4E4B 18 E8         [12]  145     jr _end_of_animation
                            146 
                            147 
                            148 
                            149 ;; ------------------------------
                            150 
   4E4D                     151 move_player::
                            152     
   4E4D 3A BE 4D      [13]  153     ld a, (target_player_position)
   4E50 DD 77 03      [19]  154     ld e_y(ix), a
   4E53 C9            [10]  155     ret 
                            156 

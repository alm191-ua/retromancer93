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
   4DA8                       7 target_player_position::
   4DA8 2A                    8     .db #LANE1_Y-8
                              9 
   4DA9                      10 enemy_void_anim::
   4DA9 00 48                11     .dw _spr_aliens_0
   4DAB 80 48                12     .dw _spr_aliens_1
   4DAD 00 00                13     .dw 0x0000
   4DAF A9 4D                14     .dw enemy_void_anim
                             15 
   4DB1                      16 enemy_o_anim::
   4DB1 00 49                17     .dw _spr_aliens_2
   4DB3 80 49                18     .dw _spr_aliens_3
   4DB5 00 00                19     .dw 0x0000
   4DB7 B1 4D                20     .dw enemy_o_anim
                             21 
   4DB9                      22 enemy_p_anim::
   4DB9 00 4A                23     .dw _spr_aliens_4
   4DBB 80 4A                24     .dw _spr_aliens_5
   4DBD 00 00                25     .dw 0x0000
   4DBF B9 4D                26     .dw enemy_p_anim
                             27 
   4DC1                      28 player_standby_anim::
   4DC1 00 46                29     .dw _spr_player_0
   4DC3 00 47                30     .dw _spr_player_1
   4DC5 00 00                31     .dw 0x0000
   4DC7 C1 4D                32     .dw player_standby_anim
                             33 
   4DC9                      34 player_tp_anim::
   4DC9 00 40                35     .dw _spr_player_tp_0
   4DCB 00 41                36     .dw _spr_player_tp_1
                             37     ;.dw _spr_player_tp_2
   4DCD 00 43                38     .dw _spr_player_tp_3
                             39     ;.dw _spr_player_tp_4
   4DCF 00 45                40     .dw _spr_player_tp_5
   4DD1 01 00                41     .dw 0x0001
   4DD3 37 4E                42     .dw move_player
   4DD5 D7 4D                43     .dw player_tp_mirror_anim
                             44 
   4DD7                      45 player_tp_mirror_anim::
   4DD7 00 45                46     .dw _spr_player_tp_5
                             47     ;.dw _spr_player_tp_4
   4DD9 00 43                48     .dw _spr_player_tp_3
                             49     ;.dw _spr_player_tp_2
   4DDB 00 41                50     .dw _spr_player_tp_1
   4DDD 00 40                51     .dw _spr_player_tp_0
   4DDF 00 00                52     .dw 0x0000
   4DE1 C1 4D                53     .dw player_standby_anim
                             54 
                             55 
                             56 ;; ----------------------------- :D
                             57 ;; Input:
                             58 ;;      IX = entity to update its animation
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   4DE3                      59 sys_animation_update::
                             60 
   4DE3 3A 80 4D      [13]   61     ld      a, (frame_counter)
   4DE6 E6 0F         [ 7]   62     and     #animation_speed
   4DE8 C0            [11]   63     ret nz
                             64 
                             65     ; ld ix, #player
                             66 
                             67     ;; Increments anim_counter
   4DE9 DD 7E 0A      [19]   68     ld a, e_anim_counter(ix)
   4DEC 3C            [ 4]   69     inc a
   4DED DD 77 0A      [19]   70     ld e_anim_counter(ix), a
                             71 
                             72     ;; Saves animation in hl
   4DF0 DD 6E 08      [19]   73     ld l, e_anim(ix)
   4DF3 DD 66 09      [19]   74     ld h, e_anim+1(ix)
   4DF6 87            [ 4]   75     add a
   4DF7 85            [ 4]   76     add l
   4DF8 30 01         [12]   77     jr nc, _no_carry
   4DFA 24            [ 4]   78     inc h
   4DFB                      79  _no_carry:
   4DFB 6F            [ 4]   80     ld l, a
                             81     ;; Saves the next sprite in DE
   4DFC 5E            [ 7]   82     ld e, (hl)
   4DFD 23            [ 6]   83     inc hl
   4DFE 56            [ 7]   84     ld d, (hl)
                             85 
                             86     ;; --Checks end of animation--
   4DFF 7A            [ 4]   87     ld a, d
   4E00 FE 00         [ 7]   88     cp #0
   4E02 20 14         [12]   89     jr nz, _next_sprite
                             90 
                             91     ;; checks type of animation
                             92     ;; execute function or not
   4E04 7B            [ 4]   93     ld a, e
   4E05 FE 00         [ 7]   94     cp #0
   4E07 28 16         [12]   95     jr z, _end_of_animation
   4E09 7B            [ 4]   96     ld a, e
   4E0A FE 01         [ 7]   97     cp #1
   4E0C 28 1B         [12]   98     jr z, _execute_function
                             99 
   4E0E                     100  _next_anim:
                            101     ;; de -> next anim pointer
   4E0E DD 73 08      [19]  102     ld e_anim  (ix), e
   4E11 DD 72 09      [19]  103     ld e_anim+1(ix), d
   4E14 EB            [ 4]  104     ex de, hl
   4E15 5E            [ 7]  105     ld e, (hl)
   4E16 23            [ 6]  106     inc hl
   4E17 56            [ 7]  107     ld d, (hl)
                            108     ;; de -> next sprite
   4E18                     109  _next_sprite:
   4E18 DD 73 04      [19]  110     ld e_sprite  (ix), e
   4E1B DD 72 05      [19]  111     ld e_sprite+1(ix), d
   4E1E C9            [10]  112     ret
                            113 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   4E1F                     114  _end_of_animation:
   4E1F DD 36 0A 00   [19]  115     ld e_anim_counter(ix), #0
   4E23 23            [ 6]  116     inc hl
                            117 
                            118     ;; hl -> next anim pointer
   4E24 5E            [ 7]  119     ld e, (hl)
   4E25 23            [ 6]  120     inc hl
   4E26 56            [ 7]  121     ld d, (hl)
                            122 
                            123     ; ex de, hl
                            124 
                            125     ; ;; hl -> next anim
                            126     ; ld e, (hl)
                            127     ; inc hl
                            128     ; ld d, (hl)
                            129 
   4E27 18 E5         [12]  130     jr _next_anim
                            131 
   4E29                     132  _execute_function:
   4E29 23            [ 6]  133     inc hl
   4E2A 5E            [ 7]  134     ld e, (hl)
   4E2B 23            [ 6]  135     inc hl
   4E2C 56            [ 7]  136     ld d, (hl)
   4E2D EB            [ 4]  137     ex de, hl
                            138     
   4E2E 22 32 4E      [16]  139     ld (_func), hl
                     008A   140     _func = .+1
   4E31 CD 32 4E      [17]  141     call (_func)
                            142 
   4E34 EB            [ 4]  143     ex  de, hl ;;; TODO: comprobar estado de HL y DE
                            144 
   4E35 18 E8         [12]  145     jr _end_of_animation
                            146 
                            147 
                            148 
                            149 ;; ------------------------------
                            150 
   4E37                     151 move_player::
                            152     
   4E37 3A A8 4D      [13]  153     ld a, (target_player_position)
   4E3A DD 77 03      [19]  154     ld e_y(ix), a
   4E3D C9            [10]  155     ret 
                            156 

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
                             23 .globl enemy_death_anim
                             24 
                             25 .globl sys_animation_update
                             26 
                             27 .globl target_player_position
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
                             14 
                     0000    15 type_invalid    =   0
                     0001    16 type_enemy_o    =   1
                     0002    17 type_enemy_p    =   2
                     0003    18 type_enemy_void =   3
                     0004    19 type_player     =   4
                     0005    20 type_trigger    =   5
                             21 
                     0000    22 e_cmp_default   =   0x00
                     0001    23 e_cmp_ia        =   0x01
                     0002    24 e_cmp_movable   =   0x02
                     0004    25 e_cmp_render    =   0x04
                     0008    26 e_cmp_collider  =   0x08
                     0010    27 e_cmp_animated  =   0x10
                     0020    28 e_cmp_input     =   0x20
                     0040    29 e_cmp_set4dead  =   0x40
                     0080    30 e_cmp_dead      =   0x80
                             31 
                             32 
                     0032    33 LANE1_Y = 50
                     0078    34 LANE2_Y = 120
                             35 
                     002A    36 LANE1_Y_PLAYER = LANE1_Y-8
                     0070    37 LANE2_Y_PLAYER = LANE2_Y-8
                             38 
                     000A    39 max_enemies = 10
                             40 
                     0000    41 e_type = 0
                     0001    42 e_comp = 1
                     0002    43 e_x = 2
                     0003    44 e_y = 3
                     0004    45 e_sprite = 4
                     0006    46 e_ia = 6
                     0008    47 e_anim = 8
                     000A    48 e_anim_counter = 10
                     000B    49 e_collides = 11
                             50 
                     000C    51 e_h = 12
                     000D    52 e_w = 13
                             53 
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
   4DC4                       7 target_player_position::
   4DC4 2A                    8     .db #LANE1_Y_PLAYER
                              9 
   4DC5                      10 enemy_death_anim::
   4DC5 00 49                11     .dw _spr_aliens_2
   4DC7 80 49                12     .dw _spr_aliens_3
   4DC9 00 49                13     .dw _spr_aliens_2
   4DCB 80 49                14     .dw _spr_aliens_3
   4DCD 00 49                15     .dw _spr_aliens_2
   4DCF 80 49                16     .dw _spr_aliens_3
   4DD1 01 00                17     .dw 0x0001
   4DD3 F4 4C                18     .dw man_enemy_set4destruction
   4DD5 D7 4D                19     .dw enemy_void_anim
                             20 
   4DD7                      21 enemy_void_anim::
   4DD7 00 48                22     .dw _spr_aliens_0
   4DD9 80 48                23     .dw _spr_aliens_1
   4DDB 00 00                24     .dw 0x0000
   4DDD D7 4D                25     .dw enemy_void_anim
                             26 
   4DDF                      27 enemy_o_anim::
   4DDF 00 49                28     .dw _spr_aliens_2
   4DE1 80 49                29     .dw _spr_aliens_3
   4DE3 00 00                30     .dw 0x0000
   4DE5 DF 4D                31     .dw enemy_o_anim
                             32 
   4DE7                      33 enemy_p_anim::
   4DE7 00 4A                34     .dw _spr_aliens_4
   4DE9 80 4A                35     .dw _spr_aliens_5
   4DEB 00 00                36     .dw 0x0000
   4DED E7 4D                37     .dw enemy_p_anim
                             38 
   4DEF                      39 player_standby_anim::
   4DEF 00 46                40     .dw _spr_player_0
   4DF1 00 47                41     .dw _spr_player_1
   4DF3 00 00                42     .dw 0x0000
   4DF5 EF 4D                43     .dw player_standby_anim
                             44 
   4DF7                      45 player_tp_anim::
   4DF7 00 40                46     .dw _spr_player_tp_0
   4DF9 00 41                47     .dw _spr_player_tp_1
                             48     ;.dw _spr_player_tp_2
   4DFB 00 43                49     .dw _spr_player_tp_3
                             50     ;.dw _spr_player_tp_4
   4DFD 00 45                51     .dw _spr_player_tp_5
   4DFF 01 00                52     .dw 0x0001
   4E01 65 4E                53     .dw move_player
   4E03 05 4E                54     .dw player_tp_mirror_anim
                             55 
   4E05                      56 player_tp_mirror_anim::
   4E05 00 45                57     .dw _spr_player_tp_5
                             58     ;.dw _spr_player_tp_4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   4E07 00 43                59     .dw _spr_player_tp_3
                             60     ;.dw _spr_player_tp_2
   4E09 00 41                61     .dw _spr_player_tp_1
   4E0B 00 40                62     .dw _spr_player_tp_0
   4E0D 00 00                63     .dw 0x0000
   4E0F EF 4D                64     .dw player_standby_anim
                             65 
                             66 
                             67 ;; ----------------------------- :D
                             68 ;; Input:
                             69 ;;      IX = entity to update its animation
   4E11                      70 sys_animation_update::
                             71 
   4E11 3A 96 4D      [13]   72     ld      a, (frame_counter)
   4E14 E6 0F         [ 7]   73     and     #animation_speed
   4E16 C0            [11]   74     ret nz
                             75 
                             76     ; ld ix, #player
                             77 
                             78     ;; Increments anim_counter
   4E17 DD 7E 0A      [19]   79     ld a, e_anim_counter(ix)
   4E1A 3C            [ 4]   80     inc a
   4E1B DD 77 0A      [19]   81     ld e_anim_counter(ix), a
                             82 
                             83     ;; Saves animation in hl
   4E1E DD 6E 08      [19]   84     ld l, e_anim(ix)
   4E21 DD 66 09      [19]   85     ld h, e_anim+1(ix)
   4E24 87            [ 4]   86     add a
   4E25 85            [ 4]   87     add l
   4E26 30 01         [12]   88     jr nc, _no_carry
   4E28 24            [ 4]   89     inc h
   4E29                      90  _no_carry:
   4E29 6F            [ 4]   91     ld l, a
                             92     ;; Saves the next sprite in DE
   4E2A 5E            [ 7]   93     ld e, (hl)
   4E2B 23            [ 6]   94     inc hl
   4E2C 56            [ 7]   95     ld d, (hl)
                             96 
                             97     ;; --Checks end of animation--
   4E2D 7A            [ 4]   98     ld a, d
   4E2E FE 00         [ 7]   99     cp #0
   4E30 20 14         [12]  100     jr nz, _next_sprite
                            101 
                            102     ;; checks type of animation
                            103     ;; execute function or not
   4E32 7B            [ 4]  104     ld a, e
   4E33 FE 00         [ 7]  105     cp #0
   4E35 28 16         [12]  106     jr z, _end_of_animation
   4E37 7B            [ 4]  107     ld a, e
   4E38 FE 01         [ 7]  108     cp #1
   4E3A 28 1B         [12]  109     jr z, _execute_function
                            110 
   4E3C                     111  _next_anim:
                            112     ;; de -> next anim pointer
   4E3C DD 73 08      [19]  113     ld e_anim  (ix), e
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   4E3F DD 72 09      [19]  114     ld e_anim+1(ix), d
   4E42 EB            [ 4]  115     ex de, hl
   4E43 5E            [ 7]  116     ld e, (hl)
   4E44 23            [ 6]  117     inc hl
   4E45 56            [ 7]  118     ld d, (hl)
                            119     ;; de -> next sprite
   4E46                     120  _next_sprite:
   4E46 DD 73 04      [19]  121     ld e_sprite  (ix), e
   4E49 DD 72 05      [19]  122     ld e_sprite+1(ix), d
   4E4C C9            [10]  123     ret
                            124 
   4E4D                     125  _end_of_animation:
   4E4D DD 36 0A 00   [19]  126     ld e_anim_counter(ix), #0
   4E51 23            [ 6]  127     inc hl
                            128 
                            129     ;; hl -> next anim pointer
   4E52 5E            [ 7]  130     ld e, (hl)
   4E53 23            [ 6]  131     inc hl
   4E54 56            [ 7]  132     ld d, (hl)
                            133 
                            134     ; ex de, hl
                            135 
                            136     ; ;; hl -> next anim
                            137     ; ld e, (hl)
                            138     ; inc hl
                            139     ; ld d, (hl)
                            140 
   4E55 18 E5         [12]  141     jr _next_anim
                            142 
   4E57                     143  _execute_function:
   4E57 23            [ 6]  144     inc hl
   4E58 5E            [ 7]  145     ld e, (hl)
   4E59 23            [ 6]  146     inc hl
   4E5A 56            [ 7]  147     ld d, (hl)
   4E5B EB            [ 4]  148     ex de, hl
                            149     
   4E5C 22 60 4E      [16]  150     ld (_func), hl
                     009C   151     _func = .+1
   4E5F CD 60 4E      [17]  152     call (_func)
                            153 
   4E62 EB            [ 4]  154     ex  de, hl ;;; TODO: comprobar estado de HL y DE
                            155 
   4E63 18 E8         [12]  156     jr _end_of_animation
                            157 
                            158 
                            159 
                            160 ;; ------------------------------
                            161 
   4E65                     162 move_player::
                            163     
   4E65 3A C4 4D      [13]  164     ld a, (target_player_position)
   4E68 DD 77 03      [19]  165     ld e_y(ix), a
   4E6B C9            [10]  166     ret 
                            167 

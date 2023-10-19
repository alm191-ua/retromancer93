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
   56C8                       7 target_player_position::
   56C8 2A                    8     .db #LANE1_Y_PLAYER
                              9 
   56C9                      10 enemy_death_anim::
   56C9 00 52                11     .dw _spr_aliens_2
   56CB 80 52                12     .dw _spr_aliens_3
   56CD 00 52                13     .dw _spr_aliens_2
   56CF 80 52                14     .dw _spr_aliens_3
   56D1 00 52                15     .dw _spr_aliens_2
   56D3 80 52                16     .dw _spr_aliens_3
   56D5 01 00                17     .dw 0x0001
   56D7 F4 55                18     .dw man_enemy_set4destruction
   56D9 DB 56                19     .dw enemy_void_anim
                             20 
   56DB                      21 enemy_void_anim::
   56DB 00 51                22     .dw _spr_aliens_0
   56DD 80 51                23     .dw _spr_aliens_1
   56DF 00 00                24     .dw 0x0000
   56E1 DB 56                25     .dw enemy_void_anim
                             26 
   56E3                      27 enemy_o_anim::
   56E3 00 52                28     .dw _spr_aliens_2
   56E5 80 52                29     .dw _spr_aliens_3
   56E7 00 00                30     .dw 0x0000
   56E9 E3 56                31     .dw enemy_o_anim
                             32 
   56EB                      33 enemy_p_anim::
   56EB 00 53                34     .dw _spr_aliens_4
   56ED 80 53                35     .dw _spr_aliens_5
   56EF 00 00                36     .dw 0x0000
   56F1 EB 56                37     .dw enemy_p_anim
                             38 
   56F3                      39 player_standby_anim::
   56F3 00 4F                40     .dw _spr_player_0
   56F5 00 50                41     .dw _spr_player_1
   56F7 00 00                42     .dw 0x0000
   56F9 F3 56                43     .dw player_standby_anim
                             44 
   56FB                      45 player_tp_anim::
   56FB 00 49                46     .dw _spr_player_tp_0
   56FD 00 4A                47     .dw _spr_player_tp_1
                             48     ;.dw _spr_player_tp_2
   56FF 00 4C                49     .dw _spr_player_tp_3
                             50     ;.dw _spr_player_tp_4
   5701 00 4E                51     .dw _spr_player_tp_5
   5703 01 00                52     .dw 0x0001
   5705 69 57                53     .dw move_player
   5707 09 57                54     .dw player_tp_mirror_anim
                             55 
   5709                      56 player_tp_mirror_anim::
   5709 00 4E                57     .dw _spr_player_tp_5
                             58     ;.dw _spr_player_tp_4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   570B 00 4C                59     .dw _spr_player_tp_3
                             60     ;.dw _spr_player_tp_2
   570D 00 4A                61     .dw _spr_player_tp_1
   570F 00 49                62     .dw _spr_player_tp_0
   5711 00 00                63     .dw 0x0000
   5713 F3 56                64     .dw player_standby_anim
                             65 
                             66 
                             67 ;; ----------------------------- :D
                             68 ;; Input:
                             69 ;;      IX = entity to update its animation
   5715                      70 sys_animation_update::
                             71 
   5715 3A 88 56      [13]   72     ld      a, (frame_counter)
   5718 E6 0F         [ 7]   73     and     #animation_speed
   571A C0            [11]   74     ret nz
                             75 
                             76     ; ld ix, #player
                             77 
                             78     ;; Increments anim_counter
   571B DD 7E 0A      [19]   79     ld a, e_anim_counter(ix)
   571E 3C            [ 4]   80     inc a
   571F DD 77 0A      [19]   81     ld e_anim_counter(ix), a
                             82 
                             83     ;; Saves animation in hl
   5722 DD 6E 08      [19]   84     ld l, e_anim(ix)
   5725 DD 66 09      [19]   85     ld h, e_anim+1(ix)
   5728 87            [ 4]   86     add a
   5729 85            [ 4]   87     add l
   572A 30 01         [12]   88     jr nc, _no_carry
   572C 24            [ 4]   89     inc h
   572D                      90  _no_carry:
   572D 6F            [ 4]   91     ld l, a
                             92     ;; Saves the next sprite in DE
   572E 5E            [ 7]   93     ld e, (hl)
   572F 23            [ 6]   94     inc hl
   5730 56            [ 7]   95     ld d, (hl)
                             96 
                             97     ;; --Checks end of animation--
   5731 7A            [ 4]   98     ld a, d
   5732 FE 00         [ 7]   99     cp #0
   5734 20 14         [12]  100     jr nz, _next_sprite
                            101 
                            102     ;; checks type of animation
                            103     ;; execute function or not
   5736 7B            [ 4]  104     ld a, e
   5737 FE 00         [ 7]  105     cp #0
   5739 28 16         [12]  106     jr z, _end_of_animation
   573B 7B            [ 4]  107     ld a, e
   573C FE 01         [ 7]  108     cp #1
   573E 28 1B         [12]  109     jr z, _execute_function
                            110 
   5740                     111  _next_anim:
                            112     ;; de -> next anim pointer
   5740 DD 73 08      [19]  113     ld e_anim  (ix), e
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   5743 DD 72 09      [19]  114     ld e_anim+1(ix), d
   5746 EB            [ 4]  115     ex de, hl
   5747 5E            [ 7]  116     ld e, (hl)
   5748 23            [ 6]  117     inc hl
   5749 56            [ 7]  118     ld d, (hl)
                            119     ;; de -> next sprite
   574A                     120  _next_sprite:
   574A DD 73 04      [19]  121     ld e_sprite  (ix), e
   574D DD 72 05      [19]  122     ld e_sprite+1(ix), d
   5750 C9            [10]  123     ret
                            124 
   5751                     125  _end_of_animation:
   5751 DD 36 0A 00   [19]  126     ld e_anim_counter(ix), #0
   5755 23            [ 6]  127     inc hl
                            128 
                            129     ;; hl -> next anim pointer
   5756 5E            [ 7]  130     ld e, (hl)
   5757 23            [ 6]  131     inc hl
   5758 56            [ 7]  132     ld d, (hl)
                            133 
                            134     ; ex de, hl
                            135 
                            136     ; ;; hl -> next anim
                            137     ; ld e, (hl)
                            138     ; inc hl
                            139     ; ld d, (hl)
                            140 
   5759 18 E5         [12]  141     jr _next_anim
                            142 
   575B                     143  _execute_function:
   575B 23            [ 6]  144     inc hl
   575C 5E            [ 7]  145     ld e, (hl)
   575D 23            [ 6]  146     inc hl
   575E 56            [ 7]  147     ld d, (hl)
   575F EB            [ 4]  148     ex de, hl
                            149     
   5760 22 64 57      [16]  150     ld (_func), hl
                     009C   151     _func = .+1
   5763 CD 64 57      [17]  152     call (_func)
                            153 
   5766 EB            [ 4]  154     ex  de, hl ;;; TODO: comprobar estado de HL y DE
                            155 
   5767 18 E8         [12]  156     jr _end_of_animation
                            157 
                            158 
                            159 
                            160 ;; ------------------------------
                            161 
   5769                     162 move_player::
                            163     
   5769 3A C8 56      [13]  164     ld a, (target_player_position)
   576C DD 77 03      [19]  165     ld e_y(ix), a
   576F C9            [10]  166     ret 
                            167 

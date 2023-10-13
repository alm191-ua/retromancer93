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
                             25 .globl sys_player_animation_update
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
                     000A    34 max_enemies = 10
                             35 
                     0000    36 e_type = 0
                     0001    37 e_comp = 1
                     0002    38 e_x = 2
                     0003    39 e_y = 3
                     0004    40 e_sprite = 4
                     0006    41 e_ia = 6
                     0008    42 e_anim = 8
                     000A    43 e_anim_counter = 10
                     000B    44 e_collides = 11
                             45 
                     000C    46 e_h = 12
                     000D    47 e_w = 13
                             48 
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
   4BFC                       7 target_player_position::
   4BFC 2A                    8     .db #LANE1_Y-8
                              9 
   4BFD                      10 enemy_void_anim::
   4BFD 00 48                11     .dw _spr_aliens_0
   4BFF 80 48                12     .dw _spr_aliens_1
   4C01 00 00                13     .dw 0x0000
   4C03 FD 4B                14     .dw enemy_void_anim
                             15 
   4C05                      16 enemy_o_anim::
   4C05 00 49                17     .dw _spr_aliens_2
   4C07 80 49                18     .dw _spr_aliens_3
   4C09 00 00                19     .dw 0x0000
   4C0B 05 4C                20     .dw enemy_o_anim
                             21 
   4C0D                      22 enemy_p_anim::
   4C0D 00 4A                23     .dw _spr_aliens_4
   4C0F 80 4A                24     .dw _spr_aliens_5
   4C11 00 00                25     .dw 0x0000
   4C13 0D 4C                26     .dw enemy_p_anim
                             27 
   4C15                      28 player_standby_anim::
   4C15 00 46                29     .dw _spr_player_0
   4C17 00 47                30     .dw _spr_player_1
   4C19 00 00                31     .dw 0x0000
   4C1B 15 4C                32     .dw player_standby_anim
                             33 
   4C1D                      34 player_tp_anim::
   4C1D 00 40                35     .dw _spr_player_tp_0
   4C1F 00 41                36     .dw _spr_player_tp_1
                             37     ;.dw _spr_player_tp_2
   4C21 00 43                38     .dw _spr_player_tp_3
                             39     ;.dw _spr_player_tp_4
   4C23 00 45                40     .dw _spr_player_tp_5
   4C25 01 00                41     .dw 0x0001
   4C27 C9 4C                42     .dw move_player
   4C29 2B 4C                43     .dw player_tp_mirror_anim
                             44 
   4C2B                      45 player_tp_mirror_anim::
   4C2B 00 45                46     .dw _spr_player_tp_5
                             47     ;.dw _spr_player_tp_4
   4C2D 00 43                48     .dw _spr_player_tp_3
                             49     ;.dw _spr_player_tp_2
   4C2F 00 41                50     .dw _spr_player_tp_1
   4C31 00 40                51     .dw _spr_player_tp_0
   4C33 00 00                52     .dw 0x0000
   4C35 15 4C                53     .dw player_standby_anim
                             54 
                             55 ;; INPUT:
                             56 ;; IX = entity to update its animation
   4C37                      57 sys_animation_update::
                             58     
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             59     ;; Increments anim_counter
   4C37 DD 7E 0A      [19]   60     ld a, e_anim_counter(ix)
   4C3A 3C            [ 4]   61     inc a
   4C3B DD 77 0A      [19]   62     ld e_anim_counter(ix), a
                             63 
                             64     ;; Saves animation in hl
   4C3E DD 6E 08      [19]   65     ld l, e_anim(ix)
   4C41 DD 66 09      [19]   66     ld h, e_anim+1(ix)
   4C44 87            [ 4]   67     add a
   4C45 85            [ 4]   68     add l
   4C46 30 01         [12]   69     jr nc, no_carry
   4C48 24            [ 4]   70     inc h
   4C49                      71  no_carry:
   4C49 6F            [ 4]   72     ld l, a
                             73     ;; Saves the next sprite in DE
   4C4A 5E            [ 7]   74     ld e, (hl)
   4C4B 23            [ 6]   75     inc hl
   4C4C 56            [ 7]   76     ld d, (hl)
                             77 
                             78     ;; Checks if the last sprite was the end of the animation
                             79 
   4C4D 7B            [ 4]   80     ld a, e
   4C4E FE 00         [ 7]   81     cp #0
   4C50 20 05         [12]   82     jr nz, next_sprite
                             83 
   4C52 7A            [ 4]   84     ld a, d
   4C53 FE 00         [ 7]   85     cp #0
   4C55 28 07         [12]   86     jr z, end_of_animation
                             87 
   4C57                      88  next_sprite:
   4C57 DD 73 04      [19]   89     ld e_sprite(ix), e
   4C5A DD 72 05      [19]   90     ld e_sprite+1(ix), d
   4C5D C9            [10]   91     ret
                             92 
   4C5E                      93  end_of_animation:
   4C5E DD 36 0A 00   [19]   94     ld e_anim_counter(ix), #0
   4C62 23            [ 6]   95     inc hl
                             96 
   4C63 5E            [ 7]   97     ld e, (hl)
   4C64 23            [ 6]   98     inc hl
   4C65 56            [ 7]   99     ld d, (hl)
                            100 
   4C66 EB            [ 4]  101     ex de, hl
                            102 
   4C67 5E            [ 7]  103     ld e, (hl)
   4C68 23            [ 6]  104     inc hl
   4C69 56            [ 7]  105     ld d, (hl)
                            106 
   4C6A 18 EB         [12]  107     jr next_sprite
                            108 
                            109 
                            110 
                            111 
                            112 ;; ----------------------------- :D
   4C6C                     113 sys_player_animation_update::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            114 
   4C6C 3A 26 4F      [13]  115     ld      a, (frame_counter)
   4C6F E6 0F         [ 7]  116     and     #animation_speed
   4C71 C0            [11]  117     ret nz
                            118 
   4C72 DD 21 8C 4D   [14]  119     ld ix, #player
                            120 
                            121     ;; Increments anim_counter
   4C76 DD 7E 0A      [19]  122     ld a, e_anim_counter(ix)
   4C79 3C            [ 4]  123     inc a
   4C7A DD 77 0A      [19]  124     ld e_anim_counter(ix), a
                            125 
                            126     ;; Saves animation in hl
   4C7D DD 6E 08      [19]  127     ld l, e_anim(ix)
   4C80 DD 66 09      [19]  128     ld h, e_anim+1(ix)
   4C83 87            [ 4]  129     add a
   4C84 85            [ 4]  130     add l
   4C85 30 01         [12]  131     jr nc, _no_carry_player
   4C87 24            [ 4]  132     inc h
   4C88                     133  _no_carry_player:
   4C88 6F            [ 4]  134     ld l, a
                            135     ;; Saves the next sprite in DE
   4C89 5E            [ 7]  136     ld e, (hl)
   4C8A 23            [ 6]  137     inc hl
   4C8B 56            [ 7]  138     ld d, (hl)
                            139 
                            140     ;; Checks if the last sprite was the end of the animation
                            141 
   4C8C 7A            [ 4]  142     ld a, d
   4C8D FE 00         [ 7]  143     cp #0
   4C8F 20 0A         [12]  144     jr nz, _next_sprite_player
                            145 
   4C91 7B            [ 4]  146     ld a, e
   4C92 FE 00         [ 7]  147     cp #0
   4C94 28 0C         [12]  148     jr z, _end_of_animation_player
   4C96 7B            [ 4]  149     ld a, e
   4C97 FE 01         [ 7]  150     cp #1
   4C99 28 15         [12]  151     jr z, _execute_function_player
                            152 
   4C9B                     153  _next_sprite_player:
   4C9B DD 73 04      [19]  154     ld e_sprite(ix), e
   4C9E DD 72 05      [19]  155     ld e_sprite+1(ix), d
   4CA1 C9            [10]  156     ret
                            157 
   4CA2                     158  _end_of_animation_player:
   4CA2 DD 36 0A 00   [19]  159     ld e_anim_counter(ix), #0
   4CA6 23            [ 6]  160     inc hl
                            161 
   4CA7 5E            [ 7]  162     ld e, (hl)
   4CA8 23            [ 6]  163     inc hl
   4CA9 56            [ 7]  164     ld d, (hl)
                            165 
   4CAA EB            [ 4]  166     ex de, hl
                            167 
   4CAB 5E            [ 7]  168     ld e, (hl)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   4CAC 23            [ 6]  169     inc hl
   4CAD 56            [ 7]  170     ld d, (hl)
                            171 
   4CAE 18 A7         [12]  172     jr next_sprite
                            173 
   4CB0                     174  _execute_function_player:
   4CB0 23            [ 6]  175     inc hl
   4CB1 5E            [ 7]  176     ld e, (hl)
   4CB2 23            [ 6]  177     inc hl
   4CB3 56            [ 7]  178     ld d, (hl)
   4CB4 EB            [ 4]  179     ex de, hl
                            180     
   4CB5 22 B9 4C      [16]  181     ld (_func), hl
                     00BD   182     _func = .+1
   4CB8 CD B9 4C      [17]  183     call (_func)
   4CBB 23            [ 6]  184     inc hl
                            185 
   4CBC DD 36 0A 00   [19]  186     ld e_anim_counter(ix), #0
                            187 
   4CC0 5E            [ 7]  188     ld e, (hl)
   4CC1 23            [ 6]  189     inc hl
   4CC2 56            [ 7]  190     ld d, (hl)
                            191 
   4CC3 EB            [ 4]  192     ex de, hl
                            193 
   4CC4 5E            [ 7]  194     ld e, (hl)
   4CC5 23            [ 6]  195     inc hl
   4CC6 56            [ 7]  196     ld d, (hl)
   4CC7 18 D2         [12]  197     jr _next_sprite_player
                            198 
   4CC9                     199 move_player::
                            200     
   4CC9 3A FC 4B      [13]  201     ld a, (target_player_position)
   4CCC DD 77 03      [19]  202     ld e_y(ix), a
   4CCF C9            [10]  203     ret 
                            204 

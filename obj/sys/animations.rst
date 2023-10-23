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
                             42 .globl _spr_caldero_0
                             43 .globl _spr_caldero_1
                             44 .globl _spr_caldero_2
                             45 .globl _spr_caldero_3
                             46 
                             47 .globl _spr_icono_caldero_0
                             48 .globl _spr_icono_caldero_1
                             49 
                             50 
                             51 .globl enemy_void_death_anim
                             52 .globl enemy_o_death_anim
                             53 .globl enemy_p_death_anim
                             54 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             55 .globl enemy_void_anim
                             56 .globl enemy_o_anim
                             57 .globl enemy_p_anim
                             58 
                             59 .globl player_standby_anim
                             60 .globl player_tp_anim
                             61 .globl player_tp_mirror_anim
                             62 .globl player_attack_null
                             63 .globl player_attack_o
                             64 .globl player_attack_p
                             65 
                             66 .globl sys_animation_update
                             67 .globl sys_animation_update_fast
                             68 .globl sys_animation_update_custom_speed
                             69 .globl target_player_position
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                     0000    55 e_type          = 0
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
                              1 .globl cpct_getScreenPtr_asm
                              2 .globl cpct_drawSprite_asm
                              3 .globl cpct_setVideoMode_asm
                              4 .globl _g_palette
                              5 .globl cpct_setPalette_asm
                              6 
                              7 .globl sys_render_init
                              8 .globl sys_render_update
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                              6 
                     0003     7 animation_speed = 3
                              8 
   7945                       9 target_player_position::
   7945 32                   10     .db #LANE1_Y_PLAYER
                             11 
   7946                      12 enemy_null_anim:
   7946 C0 71                13     .dw _spr_alien_void_5 
   7948 00 00                14     .dw 0x0000
   794A 46 79                15     .dw enemy_null_anim
                             16 
   794C                      17 enemy_void_death_anim::
   794C 40 6F                18     .dw _spr_alien_void_3 
   794E 80 70                19     .dw _spr_alien_void_4 
   7950 C0 71                20     .dw _spr_alien_void_5 
   7952 01 00                21     .dw 0x0001
   7954 E1 77                22     .dw man_enemy_set4destruction
   7956 46 79                23     .dw enemy_null_anim
                             24 
   7958                      25 enemy_o_death_anim::
   7958 C0 67                26     .dw _spr_alien_o_3 
   795A 00 69                27     .dw _spr_alien_o_4 
   795C 40 6A                28     .dw _spr_alien_o_5 
   795E 01 00                29     .dw 0x0001
   7960 E1 77                30     .dw man_enemy_set4destruction
   7962 46 79                31     .dw enemy_null_anim
                             32 
   7964                      33 enemy_p_death_anim::
   7964 40 60                34     .dw _spr_alien_p_3 
   7966 80 61                35     .dw _spr_alien_p_4 
   7968 C0 62                36     .dw _spr_alien_p_5 
   796A 01 00                37     .dw 0x0001
   796C E1 77                38     .dw man_enemy_set4destruction
   796E 46 79                39     .dw enemy_null_anim
                             40 
   7970                      41 enemy_void_anim::
   7970 80 6B                42     .dw _spr_alien_void_0
   7972 C0 6C                43     .dw _spr_alien_void_1
   7974 00 6E                44     .dw _spr_alien_void_2
   7976 00 00                45     .dw 0x0000
   7978 70 79                46     .dw enemy_void_anim
                             47 
   797A                      48 enemy_o_anim::
   797A 00 64                49     .dw _spr_alien_o_0
   797C 40 65                50     .dw _spr_alien_o_1
   797E 80 66                51     .dw _spr_alien_o_2
   7980 00 00                52     .dw 0x0000
   7982 7A 79                53     .dw enemy_o_anim
                             54 
   7984                      55 enemy_p_anim::
   7984 80 5C                56     .dw _spr_alien_p_0
   7986 C0 5D                57     .dw _spr_alien_p_1
   7988 00 5F                58     .dw _spr_alien_p_2
   798A 00 00                59     .dw 0x0000
   798C 84 79                60     .dw enemy_p_anim
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             61 
   798E                      62 player_standby_anim::
   798E 80 5A                63     .dw _spr_player_0
   7990 80 5B                64     .dw _spr_player_1
   7992 00 00                65     .dw 0x0000
   7994 8E 79                66     .dw player_standby_anim
                             67 
   7996                      68 player_tp_anim::
   7996 80 54                69     .dw _spr_player_tp_0
   7998 80 55                70     .dw _spr_player_tp_1
                             71     ;.dw _spr_player_tp_2
   799A 80 57                72     .dw _spr_player_tp_3
                             73     ;.dw _spr_player_tp_4
   799C 80 59                74     .dw _spr_player_tp_5
   799E 01 00                75     .dw 0x0001
   79A0 2D 7A                76     .dw move_player
   79A2 A4 79                77     .dw player_tp_mirror_anim
                             78 
   79A4                      79 player_tp_mirror_anim::
   79A4 80 59                80     .dw _spr_player_tp_5
                             81     ;.dw _spr_player_tp_4
   79A6 80 57                82     .dw _spr_player_tp_3
                             83     ;.dw _spr_player_tp_2
   79A8 80 55                84     .dw _spr_player_tp_1
   79AA 80 54                85     .dw _spr_player_tp_0
   79AC 00 00                86     .dw 0x0000
   79AE 8E 79                87     .dw player_standby_anim
                             88 
                             89 
   79B0                      90 player_attack_null::
   79B0 80 4E                91     .dw _spr_player_attack_09
   79B2 00 00                92     .dw 0x0000
   79B4 B0 79                93     .dw player_attack_null
                             94 
   79B6                      95 player_attack_o::
   79B6 80 4A                96     .dw _spr_player_attack_05
   79B8 80 4B                97     .dw _spr_player_attack_06
   79BA 80 4C                98     .dw _spr_player_attack_07
   79BC 80 4D                99     .dw _spr_player_attack_08
   79BE 80 4E               100     .dw _spr_player_attack_09
   79C0 00 00               101     .dw 0x0000
   79C2 B0 79               102     .dw player_attack_null
                            103 
   79C4                     104 player_attack_p::
   79C4 80 4F               105     .dw _spr_player_attack_10
   79C6 80 50               106     .dw _spr_player_attack_11
   79C8 80 51               107     .dw _spr_player_attack_12
   79CA 80 52               108     .dw _spr_player_attack_13
   79CC 80 53               109     .dw _spr_player_attack_14
   79CE 00 00               110     .dw 0x0000
   79D0 B0 79               111     .dw player_attack_null
                            112 
                            113 
                            114 ;; -------------- FUNCTIONS --------------
                            115 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            116 ;; allows to update an animation choosing the updating speed
                            117 ;; Input:
                            118 ;;      B = updating speed (1, 3, 7 ...)
   79D2                     119 sys_animation_update_custom_speed::
   79D2 3A 9F 78      [13]  120     ld      a, (frame_counter)
   79D5 A0            [ 4]  121     and     b
   79D6 C0            [11]  122     ret     nz
   79D7 18 06         [12]  123     jr      sys_animation_update_fast
                            124     
                            125 ;; Input:
                            126 ;;      IX = entity to update its animation
   79D9                     127 sys_animation_update::
                            128 
   79D9 3A 9F 78      [13]  129     ld      a, (frame_counter)
   79DC E6 03         [ 7]  130     and     #animation_speed
   79DE C0            [11]  131     ret     nz
                            132 
                            133 ;; updates the animation at real speed
                            134 ;; Input:
                            135 ;;      IX = entity to update its animation
   79DF                     136 sys_animation_update_fast::
                            137     ;; Increments anim_counter
   79DF DD 7E 0C      [19]  138     ld a, e_anim_counter(ix)
   79E2 3C            [ 4]  139     inc a
   79E3 DD 77 0C      [19]  140     ld e_anim_counter(ix), a
                            141 
                            142     ;; Saves animation in hl
   79E6 DD 6E 08      [19]  143     ld l, e_anim(ix)
   79E9 DD 66 09      [19]  144     ld h, e_anim+1(ix)
   79EC 87            [ 4]  145     add a
   79ED 85            [ 4]  146     add l
   79EE 30 01         [12]  147     jr nc, _no_carry
   79F0 24            [ 4]  148     inc h
   79F1                     149  _no_carry:
   79F1 6F            [ 4]  150     ld l, a
                            151     ;; Saves the next sprite in DE
   79F2 5E            [ 7]  152     ld e, (hl)
   79F3 23            [ 6]  153     inc hl
   79F4 56            [ 7]  154     ld d, (hl)
                            155 
                            156     ;; --Checks end of animation--
   79F5 7A            [ 4]  157     ld a, d
   79F6 FE 00         [ 7]  158     cp #0
   79F8 20 14         [12]  159     jr nz, _next_sprite
                            160 
                            161     ;; checks type of animation
                            162     ;; execute function or not
   79FA 7B            [ 4]  163     ld a, e
   79FB FE 00         [ 7]  164     cp #0
   79FD 28 16         [12]  165     jr z, _end_of_animation
   79FF 7B            [ 4]  166     ld a, e
   7A00 FE 01         [ 7]  167     cp #1
   7A02 28 1B         [12]  168     jr z, _execute_function
                            169 
   7A04                     170  _next_anim:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            171     ;; de -> next anim pointer
   7A04 DD 73 08      [19]  172     ld e_anim  (ix), e
   7A07 DD 72 09      [19]  173     ld e_anim+1(ix), d
   7A0A EB            [ 4]  174     ex de, hl
   7A0B 5E            [ 7]  175     ld e, (hl)
   7A0C 23            [ 6]  176     inc hl
   7A0D 56            [ 7]  177     ld d, (hl)
                            178     ;; de -> next sprite
   7A0E                     179  _next_sprite:
   7A0E DD 73 04      [19]  180     ld e_sprite  (ix), e
   7A11 DD 72 05      [19]  181     ld e_sprite+1(ix), d
   7A14 C9            [10]  182     ret
                            183 
   7A15                     184  _end_of_animation:
   7A15 DD 36 0C 00   [19]  185     ld e_anim_counter(ix), #0
   7A19 23            [ 6]  186     inc hl
                            187 
                            188     ;; hl -> next anim pointer
   7A1A 5E            [ 7]  189     ld e, (hl)
   7A1B 23            [ 6]  190     inc hl
   7A1C 56            [ 7]  191     ld d, (hl)
                            192 
                            193     ; ex de, hl
                            194 
                            195     ; ;; hl -> next anim
                            196     ; ld e, (hl)
                            197     ; inc hl
                            198     ; ld d, (hl)
                            199 
   7A1D 18 E5         [12]  200     jr _next_anim
                            201 
   7A1F                     202  _execute_function:
   7A1F 23            [ 6]  203     inc hl
   7A20 5E            [ 7]  204     ld e, (hl)
   7A21 23            [ 6]  205     inc hl
   7A22 56            [ 7]  206     ld d, (hl)
   7A23 EB            [ 4]  207     ex de, hl
                            208     
   7A24 22 28 7A      [16]  209     ld (_func), hl
                     00E3   210     _func = .+1
   7A27 CD 28 7A      [17]  211     call (_func)
                            212 
   7A2A EB            [ 4]  213     ex  de, hl ;;; TODO: comprobar estado de HL y DE
                            214 
   7A2B 18 E8         [12]  215     jr _end_of_animation
                            216 
                            217 
                            218 
                            219 ;; ------------------------------
                            220 
   7A2D                     221 move_player::
   7A2D 3A 45 79      [13]  222     ld      a, (target_player_position)
   7A30 DD 77 03      [19]  223     ld      e_y(ix), a
                            224     ; ld      c, a
                            225     ; push    bc
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            226 
   7A33 01 10 00      [10]  227     ld      bc, #size_of_tmpl
   7A36 DD 09         [15]  228     add     ix, bc
   7A38 DD 77 03      [19]  229     ld      e_y (ix), a ;; move the player attack
                            230     ;; player attack
                            231     ; ld      hl, #_spr_player_attack_09
                            232     ; ld      e_sprite+1(ix), h ;; change sprite to erase the attack
                            233     ; ld      e_sprite  (ix), l
                            234     ; call    sys_render_update
                            235     ; pop     bc
                            236     ; ld      e_y (ix), c ;; move the player attack
   7A3B 01 F0 FF      [10]  237     ld      bc, #-size_of_tmpl
   7A3E DD 09         [15]  238     add     ix, bc
                            239 
   7A40 C9            [10]  240     ret 
                            241 

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
                              4 
                              5 .globl sys_game_inc_frames_counter
                              6 .globl sys_game_inc_points
                              7 .globl sys_game_dec_points
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
   714F                       9 target_player_position::
   714F 32                   10     .db #LANE1_Y_PLAYER
                             11 
   7150                      12 enemy_null_anim:
   7150 40 6C                13     .dw _spr_alien_void_5 
   7152 00 00                14     .dw 0x0000
   7154 50 71                15     .dw enemy_null_anim
                             16 
   7156                      17 enemy_void_death_anim::
   7156 C0 69                18     .dw _spr_alien_void_3 
   7158 00 6B                19     .dw _spr_alien_void_4 
   715A 40 6C                20     .dw _spr_alien_void_5 
   715C 01 00                21     .dw 0x0001
   715E 9C 75                22     .dw man_enemy_set4destruction
   7160 50 71                23     .dw enemy_null_anim
                             24 
   7162                      25 enemy_o_death_anim::
   7162 40 62                26     .dw _spr_alien_o_3 
   7164 80 63                27     .dw _spr_alien_o_4 
   7166 C0 64                28     .dw _spr_alien_o_5 
   7168 01 00                29     .dw 0x0001
   716A 9C 75                30     .dw man_enemy_set4destruction
   716C 50 71                31     .dw enemy_null_anim
                             32 
   716E                      33 enemy_p_death_anim::
   716E C0 5A                34     .dw _spr_alien_p_3 
   7170 00 5C                35     .dw _spr_alien_p_4 
   7172 40 5D                36     .dw _spr_alien_p_5 
   7174 01 00                37     .dw 0x0001
   7176 9C 75                38     .dw man_enemy_set4destruction
   7178 50 71                39     .dw enemy_null_anim
                             40 
   717A                      41 enemy_void_anim::
   717A 00 66                42     .dw _spr_alien_void_0
   717C 40 67                43     .dw _spr_alien_void_1
   717E 80 68                44     .dw _spr_alien_void_2
   7180 00 00                45     .dw 0x0000
   7182 7A 71                46     .dw enemy_void_anim
                             47 
   7184                      48 enemy_o_anim::
   7184 80 5E                49     .dw _spr_alien_o_0
   7186 C0 5F                50     .dw _spr_alien_o_1
   7188 00 61                51     .dw _spr_alien_o_2
   718A 00 00                52     .dw 0x0000
   718C 84 71                53     .dw enemy_o_anim
                             54 
   718E                      55 enemy_p_anim::
   718E 00 57                56     .dw _spr_alien_p_0
   7190 40 58                57     .dw _spr_alien_p_1
   7192 80 59                58     .dw _spr_alien_p_2
   7194 00 00                59     .dw 0x0000
   7196 8E 71                60     .dw enemy_p_anim
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             61 
   7198                      62 player_standby_anim::
   7198 00 55                63     .dw _spr_player_0
   719A 00 56                64     .dw _spr_player_1
   719C 00 00                65     .dw 0x0000
   719E 98 71                66     .dw player_standby_anim
                             67 
   71A0                      68 player_tp_anim::
   71A0 00 4F                69     .dw _spr_player_tp_0
   71A2 00 50                70     .dw _spr_player_tp_1
                             71     ;.dw _spr_player_tp_2
   71A4 00 52                72     .dw _spr_player_tp_3
                             73     ;.dw _spr_player_tp_4
   71A6 00 54                74     .dw _spr_player_tp_5
   71A8 01 00                75     .dw 0x0001
   71AA 37 72                76     .dw move_player
   71AC AE 71                77     .dw player_tp_mirror_anim
                             78 
   71AE                      79 player_tp_mirror_anim::
   71AE 00 54                80     .dw _spr_player_tp_5
                             81     ;.dw _spr_player_tp_4
   71B0 00 52                82     .dw _spr_player_tp_3
                             83     ;.dw _spr_player_tp_2
   71B2 00 50                84     .dw _spr_player_tp_1
   71B4 00 4F                85     .dw _spr_player_tp_0
   71B6 00 00                86     .dw 0x0000
   71B8 98 71                87     .dw player_standby_anim
                             88 
                             89 
   71BA                      90 player_attack_null::
   71BA 00 49                91     .dw _spr_player_attack_09
   71BC 00 00                92     .dw 0x0000
   71BE BA 71                93     .dw player_attack_null
                             94 
   71C0                      95 player_attack_o::
   71C0 00 45                96     .dw _spr_player_attack_05
   71C2 00 46                97     .dw _spr_player_attack_06
   71C4 00 47                98     .dw _spr_player_attack_07
   71C6 00 48                99     .dw _spr_player_attack_08
   71C8 00 49               100     .dw _spr_player_attack_09
   71CA 00 00               101     .dw 0x0000
   71CC BA 71               102     .dw player_attack_null
                            103 
   71CE                     104 player_attack_p::
   71CE 00 4A               105     .dw _spr_player_attack_10
   71D0 00 4B               106     .dw _spr_player_attack_11
   71D2 00 4C               107     .dw _spr_player_attack_12
   71D4 00 4D               108     .dw _spr_player_attack_13
   71D6 00 4E               109     .dw _spr_player_attack_14
   71D8 00 00               110     .dw 0x0000
   71DA BA 71               111     .dw player_attack_null
                            112 
                            113 
                            114 ;; -------------- FUNCTIONS --------------
                            115 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            116 ;; allows to update an animation choosing the updating speed
                            117 ;; Input:
                            118 ;;      B = updating speed (1, 3, 7 ...)
   71DC                     119 sys_animation_update_custom_speed::
   71DC 3A 4B 76      [13]  120     ld      a, (frame_counter)
   71DF A0            [ 4]  121     and     b
   71E0 C0            [11]  122     ret     nz
   71E1 18 06         [12]  123     jr      sys_animation_update_fast
                            124     
                            125 ;; Input:
                            126 ;;      IX = entity to update its animation
   71E3                     127 sys_animation_update::
                            128 
   71E3 3A 4B 76      [13]  129     ld      a, (frame_counter)
   71E6 E6 0F         [ 7]  130     and     #animation_speed
   71E8 C0            [11]  131     ret     nz
                            132 
                            133 ;; updates the animation at real speed
                            134 ;; Input:
                            135 ;;      IX = entity to update its animation
   71E9                     136 sys_animation_update_fast::
                            137     ;; Increments anim_counter
   71E9 DD 7E 0C      [19]  138     ld a, e_anim_counter(ix)
   71EC 3C            [ 4]  139     inc a
   71ED DD 77 0C      [19]  140     ld e_anim_counter(ix), a
                            141 
                            142     ;; Saves animation in hl
   71F0 DD 6E 08      [19]  143     ld l, e_anim(ix)
   71F3 DD 66 09      [19]  144     ld h, e_anim+1(ix)
   71F6 87            [ 4]  145     add a
   71F7 85            [ 4]  146     add l
   71F8 30 01         [12]  147     jr nc, _no_carry
   71FA 24            [ 4]  148     inc h
   71FB                     149  _no_carry:
   71FB 6F            [ 4]  150     ld l, a
                            151     ;; Saves the next sprite in DE
   71FC 5E            [ 7]  152     ld e, (hl)
   71FD 23            [ 6]  153     inc hl
   71FE 56            [ 7]  154     ld d, (hl)
                            155 
                            156     ;; --Checks end of animation--
   71FF 7A            [ 4]  157     ld a, d
   7200 FE 00         [ 7]  158     cp #0
   7202 20 14         [12]  159     jr nz, _next_sprite
                            160 
                            161     ;; checks type of animation
                            162     ;; execute function or not
   7204 7B            [ 4]  163     ld a, e
   7205 FE 00         [ 7]  164     cp #0
   7207 28 16         [12]  165     jr z, _end_of_animation
   7209 7B            [ 4]  166     ld a, e
   720A FE 01         [ 7]  167     cp #1
   720C 28 1B         [12]  168     jr z, _execute_function
                            169 
   720E                     170  _next_anim:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                            171     ;; de -> next anim pointer
   720E DD 73 08      [19]  172     ld e_anim  (ix), e
   7211 DD 72 09      [19]  173     ld e_anim+1(ix), d
   7214 EB            [ 4]  174     ex de, hl
   7215 5E            [ 7]  175     ld e, (hl)
   7216 23            [ 6]  176     inc hl
   7217 56            [ 7]  177     ld d, (hl)
                            178     ;; de -> next sprite
   7218                     179  _next_sprite:
   7218 DD 73 04      [19]  180     ld e_sprite  (ix), e
   721B DD 72 05      [19]  181     ld e_sprite+1(ix), d
   721E C9            [10]  182     ret
                            183 
   721F                     184  _end_of_animation:
   721F DD 36 0C 00   [19]  185     ld e_anim_counter(ix), #0
   7223 23            [ 6]  186     inc hl
                            187 
                            188     ;; hl -> next anim pointer
   7224 5E            [ 7]  189     ld e, (hl)
   7225 23            [ 6]  190     inc hl
   7226 56            [ 7]  191     ld d, (hl)
                            192 
                            193     ; ex de, hl
                            194 
                            195     ; ;; hl -> next anim
                            196     ; ld e, (hl)
                            197     ; inc hl
                            198     ; ld d, (hl)
                            199 
   7227 18 E5         [12]  200     jr _next_anim
                            201 
   7229                     202  _execute_function:
   7229 23            [ 6]  203     inc hl
   722A 5E            [ 7]  204     ld e, (hl)
   722B 23            [ 6]  205     inc hl
   722C 56            [ 7]  206     ld d, (hl)
   722D EB            [ 4]  207     ex de, hl
                            208     
   722E 22 32 72      [16]  209     ld (_func), hl
                     00E3   210     _func = .+1
   7231 CD 32 72      [17]  211     call (_func)
                            212 
   7234 EB            [ 4]  213     ex  de, hl ;;; TODO: comprobar estado de HL y DE
                            214 
   7235 18 E8         [12]  215     jr _end_of_animation
                            216 
                            217 
                            218 
                            219 ;; ------------------------------
                            220 
   7237                     221 move_player::
   7237 3A 4F 71      [13]  222     ld      a, (target_player_position)
   723A DD 77 03      [19]  223     ld      e_y(ix), a
                            224 
   723D 01 10 00      [10]  225     ld      bc, #size_of_tmpl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   7240 DD 09         [15]  226     add     ix, bc
   7242 DD 77 03      [19]  227     ld      e_y (ix), a ;; move the player attack
                            228     ; ld      e_sprite (ix), #_spr_player_attack_04 ;; change sprite to erase the attack
                            229     ; call    sys_render_update
   7245 01 F0 FF      [10]  230     ld      bc, #-size_of_tmpl
   7248 DD 09         [15]  231     add     ix, bc
                            232 
   724A C9            [10]  233     ret 
                            234 

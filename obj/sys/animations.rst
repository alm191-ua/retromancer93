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
                             31 
                             32 .globl enemy_void_death_anim
                             33 .globl enemy_o_death_anim
                             34 .globl enemy_p_death_anim
                             35 
                             36 .globl enemy_void_anim
                             37 .globl enemy_o_anim
                             38 .globl enemy_p_anim
                             39 
                             40 .globl player_standby_anim
                             41 .globl player_tp_anim
                             42 .globl player_tp_mirror_anim
                             43 
                             44 .globl sys_animation_update
                             45 .globl target_player_position
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
                     0000    50 e_type          = 0
                     0001    51 e_comp          = 1
                     0002    52 e_x             = 2
                     0003    53 e_y             = 3
                     0004    54 e_sprite        = 4  ; 2bytes
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                     0006    55 e_ia            = 6  ; 2bytes
                     0008    56 e_anim          = 8  ; 2bytes
                     000A    57 e_death_anim    = 10 ; 2bytes
                     000C    58 e_anim_counter  = 12
                     000D    59 e_collides      = 13
                     000E    60 e_h             = 14
                     000F    61 e_w             = 15
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
   737B                       7 target_player_position::
   737B 32                    8     .db #LANE1_Y_PLAYER
                              9 
   737C                      10 enemy_null_anim:
   737C 40 6C                11     .dw _spr_alien_void_5 
   737E 00 00                12     .dw 0x0000
   7380 7C 73                13     .dw enemy_null_anim
                             14 
   7382                      15 enemy_void_death_anim::
   7382 C0 69                16     .dw _spr_alien_void_3 
   7384 00 6B                17     .dw _spr_alien_void_4 
   7386 40 6C                18     .dw _spr_alien_void_5 
   7388 01 00                19     .dw 0x0001
   738A 8A 72                20     .dw man_enemy_set4destruction
   738C 7C 73                21     .dw enemy_null_anim
                             22 
   738E                      23 enemy_o_death_anim::
   738E 40 62                24     .dw _spr_alien_o_3 
   7390 80 63                25     .dw _spr_alien_o_4 
   7392 C0 64                26     .dw _spr_alien_o_5 
   7394 01 00                27     .dw 0x0001
   7396 8A 72                28     .dw man_enemy_set4destruction
   7398 7C 73                29     .dw enemy_null_anim
                             30 
   739A                      31 enemy_p_death_anim::
   739A C0 5A                32     .dw _spr_alien_p_3 
   739C 00 5C                33     .dw _spr_alien_p_4 
   739E 40 5D                34     .dw _spr_alien_p_5 
   73A0 01 00                35     .dw 0x0001
   73A2 8A 72                36     .dw man_enemy_set4destruction
   73A4 7C 73                37     .dw enemy_null_anim
                             38 
   73A6                      39 enemy_void_anim::
   73A6 00 66                40     .dw _spr_alien_void_0
   73A8 40 67                41     .dw _spr_alien_void_1
   73AA 80 68                42     .dw _spr_alien_void_2
   73AC 00 00                43     .dw 0x0000
   73AE A6 73                44     .dw enemy_void_anim
                             45 
   73B0                      46 enemy_o_anim::
   73B0 80 5E                47     .dw _spr_alien_o_0
   73B2 C0 5F                48     .dw _spr_alien_o_1
   73B4 00 61                49     .dw _spr_alien_o_2
   73B6 00 00                50     .dw 0x0000
   73B8 B0 73                51     .dw enemy_o_anim
                             52 
   73BA                      53 enemy_p_anim::
   73BA 00 57                54     .dw _spr_alien_p_0
   73BC 40 58                55     .dw _spr_alien_p_1
   73BE 80 59                56     .dw _spr_alien_p_2
   73C0 00 00                57     .dw 0x0000
   73C2 BA 73                58     .dw enemy_p_anim
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             59 
   73C4                      60 player_standby_anim::
   73C4 00 55                61     .dw _spr_player_0
   73C6 00 56                62     .dw _spr_player_1
   73C8 00 00                63     .dw 0x0000
   73CA C4 73                64     .dw player_standby_anim
                             65 
   73CC                      66 player_tp_anim::
   73CC 00 4F                67     .dw _spr_player_tp_0
   73CE 00 50                68     .dw _spr_player_tp_1
                             69     ;.dw _spr_player_tp_2
   73D0 00 52                70     .dw _spr_player_tp_3
                             71     ;.dw _spr_player_tp_4
   73D2 00 54                72     .dw _spr_player_tp_5
   73D4 01 00                73     .dw 0x0001
   73D6 3A 74                74     .dw move_player
   73D8 DA 73                75     .dw player_tp_mirror_anim
                             76 
   73DA                      77 player_tp_mirror_anim::
   73DA 00 54                78     .dw _spr_player_tp_5
                             79     ;.dw _spr_player_tp_4
   73DC 00 52                80     .dw _spr_player_tp_3
                             81     ;.dw _spr_player_tp_2
   73DE 00 50                82     .dw _spr_player_tp_1
   73E0 00 4F                83     .dw _spr_player_tp_0
   73E2 00 00                84     .dw 0x0000
   73E4 C4 73                85     .dw player_standby_anim
                             86 
                             87 
                             88 ;; ----------------------------- :D
                             89 ;; Input:
                             90 ;;      IX = entity to update its animation
   73E6                      91 sys_animation_update::
                             92 
   73E6 3A 29 73      [13]   93     ld      a, (frame_counter)
   73E9 E6 0F         [ 7]   94     and     #animation_speed
   73EB C0            [11]   95     ret nz
                             96 
                             97     ; ld ix, #player
                             98 
                             99     ;; Increments anim_counter
   73EC DD 7E 0C      [19]  100     ld a, e_anim_counter(ix)
   73EF 3C            [ 4]  101     inc a
   73F0 DD 77 0C      [19]  102     ld e_anim_counter(ix), a
                            103 
                            104     ;; Saves animation in hl
   73F3 DD 6E 08      [19]  105     ld l, e_anim(ix)
   73F6 DD 66 09      [19]  106     ld h, e_anim+1(ix)
   73F9 87            [ 4]  107     add a
   73FA 85            [ 4]  108     add l
   73FB 30 01         [12]  109     jr nc, _no_carry
   73FD 24            [ 4]  110     inc h
   73FE                     111  _no_carry:
   73FE 6F            [ 4]  112     ld l, a
                            113     ;; Saves the next sprite in DE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   73FF 5E            [ 7]  114     ld e, (hl)
   7400 23            [ 6]  115     inc hl
   7401 56            [ 7]  116     ld d, (hl)
                            117 
                            118     ;; --Checks end of animation--
   7402 7A            [ 4]  119     ld a, d
   7403 FE 00         [ 7]  120     cp #0
   7405 20 14         [12]  121     jr nz, _next_sprite
                            122 
                            123     ;; checks type of animation
                            124     ;; execute function or not
   7407 7B            [ 4]  125     ld a, e
   7408 FE 00         [ 7]  126     cp #0
   740A 28 16         [12]  127     jr z, _end_of_animation
   740C 7B            [ 4]  128     ld a, e
   740D FE 01         [ 7]  129     cp #1
   740F 28 1B         [12]  130     jr z, _execute_function
                            131 
   7411                     132  _next_anim:
                            133     ;; de -> next anim pointer
   7411 DD 73 08      [19]  134     ld e_anim  (ix), e
   7414 DD 72 09      [19]  135     ld e_anim+1(ix), d
   7417 EB            [ 4]  136     ex de, hl
   7418 5E            [ 7]  137     ld e, (hl)
   7419 23            [ 6]  138     inc hl
   741A 56            [ 7]  139     ld d, (hl)
                            140     ;; de -> next sprite
   741B                     141  _next_sprite:
   741B DD 73 04      [19]  142     ld e_sprite  (ix), e
   741E DD 72 05      [19]  143     ld e_sprite+1(ix), d
   7421 C9            [10]  144     ret
                            145 
   7422                     146  _end_of_animation:
   7422 DD 36 0C 00   [19]  147     ld e_anim_counter(ix), #0
   7426 23            [ 6]  148     inc hl
                            149 
                            150     ;; hl -> next anim pointer
   7427 5E            [ 7]  151     ld e, (hl)
   7428 23            [ 6]  152     inc hl
   7429 56            [ 7]  153     ld d, (hl)
                            154 
                            155     ; ex de, hl
                            156 
                            157     ; ;; hl -> next anim
                            158     ; ld e, (hl)
                            159     ; inc hl
                            160     ; ld d, (hl)
                            161 
   742A 18 E5         [12]  162     jr _next_anim
                            163 
   742C                     164  _execute_function:
   742C 23            [ 6]  165     inc hl
   742D 5E            [ 7]  166     ld e, (hl)
   742E 23            [ 6]  167     inc hl
   742F 56            [ 7]  168     ld d, (hl)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   7430 EB            [ 4]  169     ex de, hl
                            170     
   7431 22 35 74      [16]  171     ld (_func), hl
                     00BA   172     _func = .+1
   7434 CD 35 74      [17]  173     call (_func)
                            174 
   7437 EB            [ 4]  175     ex  de, hl ;;; TODO: comprobar estado de HL y DE
                            176 
   7438 18 E8         [12]  177     jr _end_of_animation
                            178 
                            179 
                            180 
                            181 ;; ------------------------------
                            182 
   743A                     183 move_player::
                            184     
   743A 3A 7B 73      [13]  185     ld a, (target_player_position)
   743D DD 77 03      [19]  186     ld e_y(ix), a
   7440 C9            [10]  187     ret 
                            188 

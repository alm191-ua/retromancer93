ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .include "animations.h.s"
                              1 .globl _spr_aliens_0
                              2 .globl _spr_aliens_1
                              3 .globl _spr_aliens_2
                              4 .globl _spr_aliens_3
                              5 .globl _spr_aliens_4
                              6 .globl _spr_aliens_5
                              7 
                              8 .globl enemy_void_anim
                              9 
                             10 .globl sys_animation_update
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
                              9 
                             10 .globl enemies_array
                             11 .globl player
                             12 
                     0000    13 type_invalid    =   0
                     0001    14 type_enemy_o    =   1
                     0002    15 type_enemy_p    =   2
                     0003    16 type_enemy_void =   3
                     0004    17 type_player     =   4
                     0005    18 type_trigger    =   5
                             19 
                     0000    20 e_cmp_default   =   0x00
                     0001    21 e_cmp_ia        =   0x01
                     0002    22 e_cmp_movable   =   0x02
                     0004    23 e_cmp_render    =   0x04
                     0008    24 e_cmp_collider  =   0x08
                     0010    25 e_cmp_animated  =   0x10
                     0020    26 e_cmp_input     =   0x20
                     0080    27 e_cmp_dead      =   0x80
                             28 
                             29 
                     0032    30 LANE1_Y = 50
                     0078    31 LANE2_Y = 120
                             32 
                     000A    33 max_enemies = 10
                             34 
                     0000    35 e_type = 0
                     0001    36 e_comp = 1
                     0002    37 e_x = 2
                     0003    38 e_y = 3
                     0004    39 e_sprite = 4
                     0006    40 e_ia = 6
                     0008    41 e_anim = 8
                     000A    42 e_anim_counter = 10
                     000B    43 e_collides = 11
                             44 
                     000C    45 e_h = 12
                     000D    46 e_w = 13
                             47 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              3 
   4BFC                       4 enemy_void_anim::
   4BFC 00 48                 5     .dw _spr_aliens_0
   4BFE 80 48                 6     .dw _spr_aliens_1
   4C00 00 00                 7     .dw 0x0000
   4C02 FC 4B                 8     .dw enemy_void_anim
                              9 
                             10 
                             11 ;; INPUT:
                             12 ;; IX = entity to update its animation
   4C04                      13 sys_animation_update::
                             14     
                             15     ;; Increments anim_counter
   4C04 DD 7E 0A      [19]   16     ld a, e_anim_counter(ix)
   4C07 3C            [ 4]   17     inc a
   4C08 DD 77 0A      [19]   18     ld e_anim_counter(ix), a
                             19 
                             20     ;; Saves animation in hl
   4C0B DD 6E 08      [19]   21     ld l, e_anim(ix)
   4C0E DD 66 09      [19]   22     ld h, e_anim+1(ix)
   4C11 87            [ 4]   23     add a
   4C12 85            [ 4]   24     add l
   4C13 30 01         [12]   25     jr nc, no_carry
   4C15 24            [ 4]   26     inc h
   4C16                      27 no_carry:
   4C16 6F            [ 4]   28     ld l, a
                             29     ;; Saves the next sprite in DE
   4C17 5E            [ 7]   30     ld e, (hl)
   4C18 23            [ 6]   31     inc hl
   4C19 56            [ 7]   32     ld d, (hl)
                             33 
                             34     ;; Checks if the last sprite was the end of the animation
                             35 
   4C1A 7B            [ 4]   36     ld a, e
   4C1B FE 00         [ 7]   37     cp #0
   4C1D 20 05         [12]   38     jr nz, next_sprite
                             39 
   4C1F 7A            [ 4]   40     ld a, d
   4C20 FE 00         [ 7]   41     cp #0
   4C22 28 07         [12]   42     jr z, end_of_animation
                             43 
   4C24                      44 next_sprite:
   4C24 DD 73 04      [19]   45     ld e_sprite(ix), e
   4C27 DD 72 05      [19]   46     ld e_sprite+1(ix), d
   4C2A C9            [10]   47     ret
                             48 
   4C2B                      49 end_of_animation:
   4C2B DD 36 0A 00   [19]   50     ld e_anim_counter(ix), #0
   4C2F 23            [ 6]   51     inc hl
                             52 
   4C30 5E            [ 7]   53     ld e, (hl)
   4C31 23            [ 6]   54     inc hl
   4C32 56            [ 7]   55     ld d, (hl)
                             56 
   4C33 EB            [ 4]   57     ex de, hl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             58 
   4C34 5E            [ 7]   59     ld e, (hl)
   4C35 23            [ 6]   60     inc hl
   4C36 56            [ 7]   61     ld d, (hl)
                             62 
   4C37 18 EB         [12]   63     jr next_sprite
                             64 
                             65 
                             66     

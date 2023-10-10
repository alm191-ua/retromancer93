
.globl man_entity_init
.globl man_enemy_create
.globl man_enemy_set4destruction
.globl man_enemy_destroy
.globl man_enemy_forall
.globl man_enemy_update

.globl enemies_array
.globl player

type_invalid    =   0
type_enemy_o    =   1
type_enemy_p    =   2
type_enemy_void =   3
type_player     =   4
type_trigger    =   5

e_cmp_default   =   0x00
e_cmp_ia        =   0x01
e_cmp_movable   =   0x02
e_cmp_render    =   0x04
e_cmp_collider  =   0x08
e_cmp_animated  =   0x10
e_cmp_input     =   0x20
e_cmp_dead      =   0x80


LANE1_Y = 50
LANE2_Y = 120

max_enemies = 10

e_type = 0
e_comp = 1
e_x = 2
e_y = 3
e_sprite = 4
e_ia = 6
e_anim = 8
e_anim_counter = 10
e_collides = 11

e_h = 12
e_w = 13


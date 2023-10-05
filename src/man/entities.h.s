
 .globl man_entity_init
.globl man_entity_create
.globl man_entity_set4destruction
.globl man_entity_destroy
.globl man_entity_forall
.globl man_entity_update

type_enemy_o = 1
type_enemy_p = 2
type_enemy_void = 3
type_player = 4
type_trigger = 5
type_invalid = 0

e_cmp_ia = 0x01
e_cmp_movable = 0x02
e_cmp_render = 0x04
e_cmp_collider = 0x08
e_cmp_animated = 0x10
e_cmp_input =  0x20
e_cmp_default = 0x00

LANE1_Y = 75
LANE2_Y = 125

max_enemies = 10

e_type = 1
e_comp = 2
e_x = 3
e_y = 4
e_sprite = 5
e_ia = 7
e_anim = 9
e_anim_counter = 11
e_collides = 12

e_h = 13
e_w = 14

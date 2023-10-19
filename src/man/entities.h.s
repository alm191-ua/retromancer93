
.globl man_entity_init
.globl man_enemy_create
.globl man_player_create
.globl man_enemy_set4destruction
.globl man_enemy_set4dead
.globl man_enemy_destroy
.globl man_enemy_forall
.globl man_enemy_update
.globl man_entity_forall

.globl enemies_array
.globl player
.globl first_enemy

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
e_cmp_set4dead  =   0x40
e_cmp_dead      =   0x80


LANE1_Y = 50
LANE2_Y = 120

LANE1_Y_PLAYER = LANE1_Y ;; / 16x16 enemy sprites -> LANE1_Y-8
LANE2_Y_PLAYER = LANE2_Y ;; \ 16x32 enemy sprites -> LANE1_Y

POS_X_PLAYER = 6
INIT_X_ENEMY = 69 ;; 79 (end of screen) - 10 (width of sprite)

TRIGGER_LENGTH = 20 ;; TODO: hay que hacer pruebas a ver cuál es la mejor distancia
KILLING_ENEMIES_POS = POS_X_PLAYER + TRIGGER_LENGTH

default_enemies_points_value = 2

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


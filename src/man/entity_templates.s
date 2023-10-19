.include "cpctelera.h.s"
.include "entity_templates.h.s"
.include "entities.h.s"
.include "sys/animations.h.s"

enemy_cmps = e_cmp_ia | e_cmp_movable | e_cmp_render | e_cmp_animated | e_cmp_collider
player_cmps = e_cmp_render | e_cmp_animated | e_cmp_collider 

.macro DefEntity type, comps, x, y, spr, ia, anim, anim_counter, collides, h, w
    .db type            ; Tipo del enemigo
    .db comps           ; componentes
    .db x               ; X 
    .db y               ; Y
    .dw spr             ; Sprite (TODO)
    .dw ia              ; Funcion de la IA (TODO)
    .dw anim            ; Animacion (TODO)
    .db anim_counter    ; anim_counter (todo)
    .db collides        ; collides_against 
    .db h               ; alto
    .db w               ; ancho 
.endm

tmpl_enemy_void:
    DefEntity type_enemy_void, enemy_cmps, INIT_X_ENEMY, LANE1_Y, _spr_aliens_0, 0x0000, enemy_void_anim, 0, type_trigger, 16, 8 

tmpl_enemy_o:
    DefEntity type_enemy_o   , enemy_cmps, INIT_X_ENEMY, LANE1_Y, _spr_aliens_2, 0x0000, enemy_o_anim, 0, type_trigger, 16, 8    

tmpl_enemy_p:
    DefEntity type_enemy_p   , enemy_cmps, INIT_X_ENEMY, LANE1_Y, _spr_aliens_4, 0x0000, enemy_p_anim, 0, type_trigger, 16, 8

; tmpl_trigger:
;     DefEntity type_trigger   , e_cmp_default, 0, LANE1_Y, 0x0000, 0x0000, 0x0000, 0, 0, 0, 0

tmpl_player:
    DefEntity type_player    , player_cmps  , POS_X_PLAYER, LANE1_Y_PLAYER, _spr_player_0, 0x0000, player_standby_anim, 0, 0, 32, 8


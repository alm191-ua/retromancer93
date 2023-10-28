.include "cpctelera.h.s"
.include "entity_templates.h.s"
.include "entities.h.s"
.include "sys/animations.h.s"
.include "sys/ia.h.s"

enemy_cmps  = e_cmp_movable | e_cmp_render | e_cmp_animated | e_cmp_collider
player_cmps = e_cmp_render | e_cmp_animated | e_cmp_collider 
attack_cmps = e_cmp_render | e_cmp_animated
enemy_ia_cmps = enemy_cmps | e_cmp_ia

.macro DefEntity type, comps, x, y, spr, ia, anim, death_anim, anim_counter, collides, h, w
    .db type            ; Tipo del enemigo
    .db comps           ; componentes
    .db x               ; X 
    .db y               ; Y
    .dw spr             ; Sprite
    .dw ia              ; Funcion de la IA (TODO)
    .dw anim            ; Animacion
    .dw death_anim      ; Animacion de muerte (TODO)
    .db anim_counter    ; anim_counter
    .db collides        ; collides_against 
    .db h               ; alto
    .db w               ; ancho 
.endm

tmpl_enemy_void:
    DefEntity type_enemy_void, enemy_ia_cmps, INIT_X_ENEMY, LANE1_Y, _spr_alien_void_0, ia_teleport, enemy_void_anim, enemy_void_death_anim, 0, 0, 32, 10 

tmpl_enemy_o:
    DefEntity type_enemy_o   , enemy_cmps, INIT_X_ENEMY, LANE1_Y, _spr_alien_o_0, 0x0000, enemy_o_anim, enemy_o_death_anim, 0, 0, 32, 10    

tmpl_enemy_p:
    DefEntity type_enemy_p   , enemy_cmps, INIT_X_ENEMY, LANE1_Y, _spr_alien_p_0, 0x0000, enemy_p_anim, enemy_p_death_anim, 0, 0, 32, 10

tmpl_caldero:
    DefEntity type_caldero   , enemy_cmps, INIT_X_ENEMY, LANE1_Y, _spr_caldero_0, 0x0000, caldero_anim, caldero_death_anim, 0, 0, 32, 10

; tmpl_trigger:
;     DefEntity type_trigger   , e_cmp_default, 0, LANE1_Y, 0x0000, 0x0000, 0x0000, 0, 0, 0, 0

tmpl_player:
    DefEntity type_player    , player_cmps  , POS_X_PLAYER, LANE1_Y_PLAYER, _spr_player_0, 0x0000, player_standby_anim, 0, 0, 0, 32, 8

tmpl_player_attack:
    DefEntity type_player_attack, attack_cmps, POS_X_ATTACK, LANE1_Y_PLAYER, _spr_player_attack_04, 0x0000, player_attack_null, 0, 0, 0, 32, 8
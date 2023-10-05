.include "cpctelera.h.s"
.include "entity_templates.h.s"
.include "entities.h.s"

tmpl_enemy_void:
    .db  type_enemy_void      ;Tipo del enemigo
    .db e_cmp_ia | e_cmp_movable | e_cmp_render | e_cmp_animated | e_cmp_collider 
    .db 100                     ; X
    .db LANE1_Y               ; Y
    .dw _spr_alien_void                ; Sprite (TODO)
    .dw 0x0000                ; Funcion de la IA (TODO)
    .dw 0x0000                ; Animacion (TODO)
    .db 0                      ; anim_counter (todo)
    .db type_trigger           ; collides_against 
    .db 16                       ;alto
    .db 8                       ;ancho   

tmpl_enemy_o:
    .db  type_enemy_o       ;Tipo del enemigo
    .db e_cmp_ia | e_cmp_movable | e_cmp_render | e_cmp_animated | e_cmp_collider 
    .db 0                     ; X
    .db LANE1_Y               ; Y
    .dw 0x0000                ; Sprite (TODO)
    .dw 0x0000                ; Funcion de la IA (TODO)
    .dw 0x0000                ; Animacion (TODO)
    .db 0                      ; anim_counter (todo)
    .db type_trigger           ; collides_against
    .db 16                       ;alto
    .db 8                       ;ancho    

tmpl_enemy_p:
    .db  type_enemy_p       ;Tipo del enemigo
    .db e_cmp_ia | e_cmp_movable | e_cmp_render | e_cmp_animated | e_cmp_collider 
    .db 0                     ; X
    .db LANE1_Y               ; Y
    .dw 0x0000                ; Sprite (TODO)
    .dw 0x0000                ; Funcion de la IA (TODO)
    .dw 0x0000                ; Animacion (TODO)
    .db 0                      ; anim_counter (todo)
    .db type_trigger           ; collides_against 
    .db 16                       ;alto
    .db 8                       ;ancho

tmpl_player:
    .db type_player       ;Tipo del enemigo
    .db e_cmp_movable | e_cmp_render | e_cmp_animated | e_cmp_collider 
    .db 0                     ; X
    .db LANE1_Y               ; Y
    .dw 0x0000                ; Sprite (TODO)
    .dw 0x0000                ; Funcion de la IA (TODO)
    .dw 0x0000                ; Animacion (TODO)
    .db 0                      ; anim_counter (todo)
    .db 0                      ; collides_against
    .db 0                       ;alto
    .db 0                       ;ancho

size_of_tmpl = 14
max_enemies = 10
size_of_array = size_of_tmpl * max_enemies
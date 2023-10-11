.include "cpctelera.h.s"
.include "entity_templates.h.s"
.include "entities.h.s"

tmpl_enemy_void:
    .db type_enemy_void         ;Tipo del enemigo
    .db e_cmp_ia | e_cmp_movable | e_cmp_render | e_cmp_animated | e_cmp_collider ; componentes
    .db 71                      ; X -> 79 (end of screen) - 8 (sprites' width)
    .db LANE1_Y                 ; Y
    .dw _spr_aliens_0         ; Sprite (TODO)
    .dw 0x0000                  ; Funcion de la IA (TODO)
    .dw 0x0000                  ; Animacion (TODO)
    .db 0                       ; anim_counter (todo)
    .db type_trigger            ; collides_against 
    .db 16                      ; alto
    .db 8                       ; ancho   

tmpl_enemy_o:
    .db type_enemy_o            ;Tipo del enemigo
    .db e_cmp_ia | e_cmp_movable | e_cmp_render | e_cmp_animated | e_cmp_collider 
    .db 71                       ; X
    .db LANE1_Y                 ; Y
    .dw _spr_aliens_2                  ; Sprite (TODO)
    .dw 0x0000                  ; Funcion de la IA (TODO)
    .dw 0x0000                  ; Animacion (TODO)
    .db 0                       ; anim_counter (todo)
    .db type_trigger            ; collides_against
    .db 16                      ;alto
    .db 8                       ;ancho    

tmpl_enemy_p:
    .db type_enemy_p             ;Tipo del enemigo
    .db e_cmp_ia | e_cmp_movable | e_cmp_render | e_cmp_animated | e_cmp_collider 
    .db 71                       ; X
    .db LANE1_Y                 ; Y
    .dw _spr_aliens_4                  ; Sprite (TODO)
    .dw 0x0000                  ; Funcion de la IA (TODO)
    .dw 0x0000                  ; Animacion (TODO)
    .db 0                       ; anim_counter (todo)
    .db type_trigger            ; collides_against 
    .db 16                      ;alto
    .db 8                       ;ancho

tmpl_trigger:
    .db type_trigger            ; Tipo del enemigo
    .db e_cmp_default           ; components
    .db 0                       ; X -> player pos
    .db LANE1_Y                 ; Y ?
    .dw 0x0000                  ; Sprite
    .dw 0x0000                  ; Funcion de la IA
    .dw 0x0000                  ; Animacion
    .db 0                       ; anim_counter
    .db 0                       ; collides_against 
    .db 0                       ; alto
    .db 0                       ; ancho

tmpl_player:
    .db type_player             ;Tipo del enemigo
    .db e_cmp_render | e_cmp_animated | e_cmp_collider 
    .db 6                       ; X -> (fixed position of the player)
    .db LANE1_Y-8               ; Y -> center the player's sprite
    .dw _spr_player_0           ; Sprite (TODO)
    .dw 0x0000                  ; Funcion de la IA (TODO)
    .dw 0x0000                  ; Animacion (TODO)
    .db 0                       ; anim_counter (todo)
    .db 0                       ; collides_against
    .db 32                      ; alto
    .db 8                       ; ancho

; size_of_tmpl = . - #tmpl_player
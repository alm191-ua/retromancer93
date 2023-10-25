.include "cpctelera.h.s"
.include "entities.h.s"
.include "entity_templates.h.s"
.include "sys/animations.h.s"


entities::
    player:         .ds size_of_tmpl 
    player_attack:  .ds size_of_tmpl
    enemies_array:  .ds size_of_array 

    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    

next_free_enemy: .dw enemies_array
first_enemy: .dw enemies_array
last_enemy: .dw enemies_array

man_entity_init:

    ld hl, #enemies_array
    ld (next_free_enemy), hl
    ld (first_enemy), hl
    ld (hl), #0

    ld  d, h                   ;; / DE = HL + 1
    ld  e, l                   
    inc de  

    ld bc, #size_of_array-1
    ldir
    ret

;; creates player and player attack
man_player_create:
    ld      hl, #player
    ex      de, hl 
    ld      hl, #tmpl_player ;; load entity template in HL
    ld      bc, #size_of_tmpl
    ldir

    ld      hl, #player_attack
    ex      de, hl 
    ld      hl, #tmpl_player_attack ;; load entity template in HL
    ld      bc, #size_of_tmpl
    ldir
    ret


;;INPUT:
;;   IX: Entities' template
;;Returns:
;;   DE = new entity
man_enemy_create:

    ld      hl, (next_free_enemy)
    ld      a, (hl)
    cp      #0xBE ;; end of entities array
    jr      z, _move_pointer_to_first
    
    cp      #type_invalid
    jr      z, _create
    ret
    
    _move_pointer_to_first: 
        ld  hl, #enemies_array
        ld  (next_free_enemy),hl
        jr  man_enemy_create

    _create:
        ld__d_ixh
        ld__e_ixl
        ld      hl, (next_free_enemy)
        ld      (last_enemy), hl
        ex      de, hl ;; load entity template in HL
        push    de  ;;  Saves the pointer to the new entity
        ld      bc, #size_of_tmpl
        ldir

        ld  (next_free_enemy), de
        pop     de

    ret
    

;; Input:
;;      IX = entity to be marked
man_enemy_set4destruction:
    ld      a, e_comp (ix)
    or      #e_cmp_dead
    ld      e_comp (ix), a
    ret

;; prepares an enemy for death, allows him to solve his unfinished business (animation)
;; Input:
;;      IX = enemy to be prepared
man_enemy_set4dead:
    ld      a, e_comp (ix)
    or      #e_cmp_set4dead
    ld      e_comp (ix), a

    ld      e_anim_counter(ix), #0
    ld      h, e_death_anim+1 (ix)
    ld      l, e_death_anim   (ix)
    ld      e_anim(ix), l
    ld      e_anim+1(ix), h
    ret

;; igual que la anterior pero la animación es la genérica
;; Input:
;;      IX = enemy to be prepared
man_enemy_set4dead_generic:
    ld      a, e_comp (ix)
    or      #e_cmp_set4dead
    ld      e_comp (ix), a

    ld      e_anim_counter(ix), #0
    ld      h, #enemy_death_anim+1
    ld      l, #enemy_death_anim
    ld      e_anim(ix), l
    ld      e_anim+1(ix), h
    ret

;; Input:
;;      IX = entity to be destroyed
man_enemy_destroy:
    ; check dead bit
    ld      a, e_comp (ix)
    and     #e_cmp_dead
    ret     z

    ;; destroy entity
    ld      e_type(ix), #type_invalid
    ld      a, (first_enemy)
    ld      b, #size_of_tmpl
    add     b
    ld      (first_enemy), a

    ret


;; Recorre únicamente los enemigos
;; Input:
;;      HL = function to call for all enemies
man_enemy_forall:
    ld      (_func), hl
    ld      ix, #enemies_array
    jr      _forall_loop

;; Recorre tanto el jugador como los enemigos
;; Input:
;;      HL = function to call for player and all enemies
man_entity_forall:
    ld      (_func), hl
    ld      ix, #player

_forall_loop:
    ;; check final of enemies array
    ld      a, (ix)
    cp      #0xBE
    ret     z

    ;; check invalid entity
    ld      a, e_type (ix)
    cp      #type_invalid
    jr      z, _continue
_func = .+1
    call    (_func)


_continue:
    ld      bc, #size_of_tmpl
    add     ix, bc
    jr      _forall_loop
    
    ret

man_enemy_update:
    ret

space_for_new_enemy:
    ld ix, (last_enemy)
    ld      a, e_x(ix) ;es ix
    ;a<61?
    sub a, #61
    ret

return_last_enemy:
    ld ix, (last_enemy)
    ret
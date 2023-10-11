.include "cpctelera.h.s"
.include "entities.h.s"
.include "entity_templates.h.s"


entities::
    player:         .ds size_of_tmpl 
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

;; 
man_player_create:
    ld      hl, #player
    ex      de, hl 
    ld      hl, #tmpl_player ;; load entity template in HL
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


;; Input:
;;      HL = function to call for all enemies
man_enemy_forall:

    ;; de momento recorre únicamente los enemigos 
    ;; ya veremos si luego hace falta más (posiblemente no)
    ld      (_func), hl
    ld      ix, #enemies_array
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

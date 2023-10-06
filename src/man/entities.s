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

;;INPUT:
;;   IX: Entities' template
;;Returns:
;;   DE = new entity
man_entity_create:

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
        jr  man_entity_create

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
man_entity_set4destruction:
    ld      a, e_comp (ix)
    or      #e_cmp_dead
    ld      e_comp (ix), a

    ret

man_entity_destroy:
    ret

man_entity_forall:
    ret

man_entity_update:
    ret

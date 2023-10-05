.include "cpctelera.h.s"
.include "entities.h.s"
.include "entity_templates.h.s"


.area _DATA

.area _CODE

entities::
    player:         .ds 14 ;; debería ser size_of_tmpl
    enemies_array:  .ds 140 ;; debería ser size_of_array

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

;INPUT:
;   IX: Entities' template
man_entity_create:

    ld      hl, (next_free_enemy)
    ld      a, (hl)
    cp      #0xBE
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
        ex  de, hl ;; load entity template in HL
        ld  de, (next_free_enemy)
        ld  bc, #size_of_tmpl

        ldir

        ld (next_free_enemy), de

    ret
    

ret
man_entity_set4destruction:
ret
man_entity_destroy:
ret
man_entity_forall:
ret
man_entity_update:
ret

.include "cpctelera.h.s"
.include "entities.h.s"
.include "entity_templates.h.s"


.area _DATA

.area _CODE

player::
    .ds size_of_tmpl

enemies_array::
    .ds size_of_array
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    .db #0xEF
    .db #0xBE
    

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

;RECIBE POR HL EL TEMPLATE DEL ENEMIGO
man_entity_create:

    ld a, (next_free_enemy)
    cp #0xBE
    jr z, _move_pointer_to_first
    
    cp #type_invalid
    jr z, _create
    ret
    
    _move_pointer_to_first:
        push hl
        ld hl, #enemies_array
        ld (next_free_enemy),hl
        pop hl
        jr man_entity_create

    _create:
        ;ld hl, #tmpl_enemy_void
        ld de, #next_free_enemy
        ld bc, #size_of_tmpl

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

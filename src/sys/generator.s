.include "generator.h.s"
.include "man/entities.h.s"
.include "man/entity_templates.h.s"
.include "cpctelera.h.s"

tempo: 
    .db 1 ; ritmo de generación de enemigos

;; Generates one enemy if there is space in the enemies array and
;;  there is space in screen
sys_generator_update:
ld hl, #0xC000
ld (hl), #4
    ret
.include "physics.h.s"
.include "man/entities.h.s"

.include "cpctelera.h.s"

speed:
    .db -1

;; UPDATE ONE ENTITY
;; Input:
;;      IX: entity to be updated
sys_physics_update:
    ld      a, (speed)
    ld      c, a
    ld      a, e_x  (ix) 
    ld      b, a
    add     c
    ld      e_x (ix), a

    sub     b
    ret     c ;; if carry, entity is out of screen

    jp      man_entity_set4destruction

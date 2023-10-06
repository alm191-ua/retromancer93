.include "physics.h.s"
.include "man/entities.h.s"

.include "cpctelera.h.s"

speed:
    .db -1

enemy_destruction_X = 15

;; UPDATE ONE ENTITY
;; Input:
;;      IX: entity to be updated
sys_physics_update:
    ;; check dead bit
    ld      a, e_comp (ix)
    and     #e_cmp_dead
    ret     nz

    ld      a, (speed)
    ld      c, a
    ld      a, e_x  (ix) 
    ld      b, a
    add     c
    ld      e_x (ix), a
    sub     #enemy_destruction_X
    

    ; sub     b
    ret     nc ;; if carry, entity is out of screen

    jp      man_entity_set4destruction

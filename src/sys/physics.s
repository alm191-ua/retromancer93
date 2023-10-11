.include "physics.h.s"
.include "man/entities.h.s"
.include "man/game.h.s"

.include "cpctelera.h.s"

speed:
    .db -1  ;; con esto podemos aumentar la velocidad

updating_speed = 3  ;; / deben ser todo 1 en binario             (1, 3, 7, ...)
                    ;; | con esto podemos reducir la velocidad a (1, 1, 1, ...)
                    ;; \                                         (2  4  8     )

enemy_destruction_X = 15    ;; posición hasta la que llegan los enemigos

;; UPDATE ONE ENTITY
;; Input:
;;      IX: entity to be updated
sys_physics_update:
    ;; check if update is needed
    ld      a, (frame_counter)
    and     #updating_speed
    ret     nz

    ;; check dead bit
    ld      a, e_comp (ix)
    and     #e_cmp_dead
    ret     nz

    ;; check movable bit
    ld      a, e_comp (ix)
    and     #e_cmp_movable
    ret     z

    ld      a, (speed)
    ld      c, a
    ld      a, e_x  (ix) 
    ld      b, a
    add     c
    ld      e_x (ix), a
    sub     #enemy_destruction_X
    

    ; sub     b
    ret     nc ;; if carry, entity is out of screen

    jp      man_enemy_set4destruction


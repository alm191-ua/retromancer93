.include "physics.h.s"
.include "man/entities.h.s"

.include "cpctelera.h.s"

speed:
    .db -1  ;; con esto podemos aumentar la velocidad

counter:
    .db 0   ;; contador de los frames para la reducción de la velocidad

updating_speed = 1  ;; / deben ser todo 1 en binario (1, 3, 7, ...)
                    ;; \ con esto podemos reducir la velocidad

enemy_destruction_X = 15    ;; posición hasta la que llegan los enemigos

;; UPDATE ONE ENTITY
;; Input:
;;      IX: entity to be updated
sys_physics_update:
    ;; check if update is needed
    ld      a, (counter)
    inc     a
    ld      (counter), a
    and     #updating_speed
    ret     nz

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

    jp      man_enemy_set4destruction

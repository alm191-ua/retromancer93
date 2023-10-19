.include "physics.h.s"
.include "man/entities.h.s"
.include "man/game.h.s"
.include "animations.h.s"

.include "cpctelera.h.s"

speed:
    .db -1  ;; con esto podemos aumentar la velocidad

updating_speed = 3  ;; / deben ser todo 1 en binario             (1, 3, 7, ...)
                    ;; | con esto podemos reducir la velocidad a (1, 1, 1, ...)
                    ;; \                                         (2  4  8     )

animation_speed = 7

enemy_destruction_X = 15    ;; posición hasta la que llegan los enemigos

;; UPDATE ONE ENTITY
;; Input:
;;      IX: entity to be updated
sys_physics_update:
    ;; check if update is needed
    ld      a, (frame_counter)
    and     #updating_speed
    ret     nz

    ;; check set for dead bit
    ;; this bit allows the enemy to show an animation before real destruction
    ld      a, e_comp (ix)
    and     #e_cmp_set4dead
    jr      z, _no_dead

    ld      a, e_x (ix)
    sub     #enemy_destruction_X
    jr      nc, _no_dead  ;; if no carry, entity is in range

    call    sys_animation_update
    ret

_no_dead:
    ;; check dead bit
    ld      a, e_comp (ix)
    and     #e_cmp_dead
    ret     nz

    ld      a, (frame_counter)
    and     #animation_speed
    jr      nz, no_animation

    ;; se actualiza el sprite en función de la animación
    ld      a, e_comp(ix)
    and     #e_cmp_animated
    jr      z, no_animation
    call    sys_animation_update
no_animation:
    ;; check movable bit
    ld      a, e_comp (ix)
    and     #e_cmp_movable
    ret     z

    ld      a, (speed)
    ld      c, a
    ld      a, e_x  (ix) 
    ld      b, a
    sub     #enemy_destruction_X
    jr      c, _kill_enemy ;; if carry, entity is out of range
    
    ld      a, b
    add     c
    ld      e_x (ix), a
    ret
    
_kill_enemy:
    call    sys_game_dec_points
    jp      man_enemy_set4dead


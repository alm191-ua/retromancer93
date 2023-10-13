.include "animations.h.s"
.include "man/entities.h.s"

enemy_void_anim::
    .dw _spr_aliens_0
    .dw _spr_aliens_1
    .dw 0x0000
    .dw enemy_void_anim


;; INPUT:
;; IX = entity to update its animation
sys_animation_update::
    
    ;; Increments anim_counter
    ld a, e_anim_counter(ix)
    inc a
    ld e_anim_counter(ix), a

    ;; Saves animation in hl
    ld l, e_anim(ix)
    ld h, e_anim+1(ix)
    add a
    add l
    jr nc, no_carry
    inc h
no_carry:
    ld l, a
    ;; Saves the next sprite in DE
    ld e, (hl)
    inc hl
    ld d, (hl)

    ;; Checks if the last sprite was the end of the animation

    ld a, e
    cp #0
    jr nz, next_sprite

    ld a, d
    cp #0
    jr z, end_of_animation

next_sprite:
    ld e_sprite(ix), e
    ld e_sprite+1(ix), d
    ret

end_of_animation:
    ld e_anim_counter(ix), #0
    inc hl

    ld e, (hl)
    inc hl
    ld d, (hl)

    ex de, hl

    ld e, (hl)
    inc hl
    ld d, (hl)

    jr next_sprite


    
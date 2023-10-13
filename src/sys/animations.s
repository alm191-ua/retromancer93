.include "animations.h.s"
.include "man/entities.h.s"
.include "man/game.h.s"

animation_speed = 15

target_player_position::
    .db #LANE1_Y-8

enemy_void_anim::
    .dw _spr_aliens_0
    .dw _spr_aliens_1
    .dw 0x0000
    .dw enemy_void_anim

enemy_o_anim::
    .dw _spr_aliens_2
    .dw _spr_aliens_3
    .dw 0x0000
    .dw enemy_o_anim

enemy_p_anim::
    .dw _spr_aliens_4
    .dw _spr_aliens_5
    .dw 0x0000
    .dw enemy_p_anim

player_standby_anim::
    .dw _spr_player_0
    .dw _spr_player_1
    .dw 0x0000
    .dw player_standby_anim

player_tp_anim::
    .dw _spr_player_tp_0
    .dw _spr_player_tp_1
    ;.dw _spr_player_tp_2
    .dw _spr_player_tp_3
    ;.dw _spr_player_tp_4
    .dw _spr_player_tp_5
    .dw 0x0001
    .dw move_player
    .dw player_tp_mirror_anim

player_tp_mirror_anim::
    .dw _spr_player_tp_5
    ;.dw _spr_player_tp_4
    .dw _spr_player_tp_3
    ;.dw _spr_player_tp_2
    .dw _spr_player_tp_1
    .dw _spr_player_tp_0
    .dw 0x0000
    .dw player_standby_anim

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




;; ----------------------------- :D
sys_player_animation_update::

    ld      a, (frame_counter)
    and     #animation_speed
    ret nz

    ld ix, #player

    ;; Increments anim_counter
    ld a, e_anim_counter(ix)
    inc a
    ld e_anim_counter(ix), a

    ;; Saves animation in hl
    ld l, e_anim(ix)
    ld h, e_anim+1(ix)
    add a
    add l
    jr nc, _no_carry_player
    inc h
 _no_carry_player:
    ld l, a
    ;; Saves the next sprite in DE
    ld e, (hl)
    inc hl
    ld d, (hl)

    ;; Checks if the last sprite was the end of the animation

    ld a, d
    cp #0
    jr nz, _next_sprite_player

    ld a, e
    cp #0
    jr z, _end_of_animation_player
    ld a, e
    cp #1
    jr z, _execute_function_player

 _next_sprite_player:
    ld e_sprite(ix), e
    ld e_sprite+1(ix), d
    ret

 _end_of_animation_player:
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

 _execute_function_player:
    inc hl
    ld e, (hl)
    inc hl
    ld d, (hl)
    ex de, hl
    
    ld (_func), hl
    _func = .+1
    call (_func)
    inc hl

    ld e_anim_counter(ix), #0

    ld e, (hl)
    inc hl
    ld d, (hl)

    ex de, hl

    ld e, (hl)
    inc hl
    ld d, (hl)
    jr _next_sprite_player

move_player::
    
    ld a, (target_player_position)
    ld e_y(ix), a
    ret 


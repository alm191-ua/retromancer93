.include "animations.h.s"
.include "man/entities.h.s"
.include "man/game.h.s"

animation_speed = 15

target_player_position::
    .db #LANE1_Y_PLAYER

enemy_death_anim::
    .dw _spr_alien_void_5 ;;TODO: se muestra otro sprite
    .dw 0x0001
    .dw man_enemy_set4destruction
    .dw enemy_void_anim

enemy_void_anim::
    .dw _spr_alien_void_0
    .dw _spr_alien_void_1
    .dw _spr_alien_void_2
    .dw 0x0000
    .dw enemy_void_anim

enemy_o_anim::
    .dw _spr_alien_o_0
    .dw _spr_alien_o_1
    .dw _spr_alien_o_2
    .dw 0x0000
    .dw enemy_o_anim

enemy_p_anim::
    .dw _spr_alien_p_0
    .dw _spr_alien_p_1
    .dw _spr_alien_p_2
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


;; ----------------------------- :D
;; Input:
;;      IX = entity to update its animation
sys_animation_update::

    ld      a, (frame_counter)
    and     #animation_speed
    ret nz

    ; ld ix, #player

    ;; Increments anim_counter
    ld a, e_anim_counter(ix)
    inc a
    ld e_anim_counter(ix), a

    ;; Saves animation in hl
    ld l, e_anim(ix)
    ld h, e_anim+1(ix)
    add a
    add l
    jr nc, _no_carry
    inc h
 _no_carry:
    ld l, a
    ;; Saves the next sprite in DE
    ld e, (hl)
    inc hl
    ld d, (hl)

    ;; --Checks end of animation--
    ld a, d
    cp #0
    jr nz, _next_sprite

    ;; checks type of animation
    ;; execute function or not
    ld a, e
    cp #0
    jr z, _end_of_animation
    ld a, e
    cp #1
    jr z, _execute_function

 _next_anim:
    ;; de -> next anim pointer
    ld e_anim  (ix), e
    ld e_anim+1(ix), d
    ex de, hl
    ld e, (hl)
    inc hl
    ld d, (hl)
    ;; de -> next sprite
 _next_sprite:
    ld e_sprite  (ix), e
    ld e_sprite+1(ix), d
    ret

 _end_of_animation:
    ld e_anim_counter(ix), #0
    inc hl

    ;; hl -> next anim pointer
    ld e, (hl)
    inc hl
    ld d, (hl)

    ; ex de, hl

    ; ;; hl -> next anim
    ; ld e, (hl)
    ; inc hl
    ; ld d, (hl)

    jr _next_anim

 _execute_function:
    inc hl
    ld e, (hl)
    inc hl
    ld d, (hl)
    ex de, hl
    
    ld (_func), hl
    _func = .+1
    call (_func)

    ex  de, hl ;;; TODO: comprobar estado de HL y DE

    jr _end_of_animation



;; ------------------------------

move_player::
    
    ld a, (target_player_position)
    ld e_y(ix), a
    ret 


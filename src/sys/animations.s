.include "animations.h.s"
.include "man/entities.h.s"
.include "man/game.h.s"

animation_speed = 15

target_player_position::
    .db #LANE1_Y_PLAYER

enemy_null_anim:
    .dw _spr_alien_void_5 
    .dw 0x0000
    .dw enemy_null_anim

enemy_void_death_anim::
    .dw _spr_alien_void_3 
    .dw _spr_alien_void_4 
    .dw _spr_alien_void_5 
    .dw 0x0001
    .dw man_enemy_set4destruction
    .dw enemy_null_anim

enemy_o_death_anim::
    .dw _spr_alien_o_3 
    .dw _spr_alien_o_4 
    .dw _spr_alien_o_5 
    .dw 0x0001
    .dw man_enemy_set4destruction
    .dw enemy_null_anim

enemy_p_death_anim::
    .dw _spr_alien_p_3 
    .dw _spr_alien_p_4 
    .dw _spr_alien_p_5 
    .dw 0x0001
    .dw man_enemy_set4destruction
    .dw enemy_null_anim

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


player_attack_null::
    .dw _spr_player_attack_09
    .dw 0x0000
    .dw player_attack_null

player_attack_o::
    .dw _spr_player_attack_05
    .dw _spr_player_attack_06
    .dw _spr_player_attack_07
    .dw _spr_player_attack_08
    .dw _spr_player_attack_09
    .dw 0x0000
    .dw player_attack_null

player_attack_p::
    .dw _spr_player_attack_10
    .dw _spr_player_attack_11
    .dw _spr_player_attack_12
    .dw _spr_player_attack_13
    .dw _spr_player_attack_14
    .dw 0x0000
    .dw player_attack_null


;; -------------- FUNCTIONS --------------

;; allows to update an animation choosing the updating speed
;; Input:
;;      B = updating speed (1, 3, 7 ...)
sys_animation_update_custom_speed::
    ld      a, (frame_counter)
    and     b
    ret     nz
    jr      sys_animation_update_fast
    
;; Input:
;;      IX = entity to update its animation
sys_animation_update::

    ld      a, (frame_counter)
    and     #animation_speed
    ret     nz

;; updates the animation at real speed
;; Input:
;;      IX = entity to update its animation
sys_animation_update_fast::
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
    ld next_entity_y (ix), a ;; move the player attack (is in the next position)
    ret 


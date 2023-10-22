.include "game.h.s"
.include "man/entities.h.s"
.include "man/entity_templates.h.s"
.include "sys/generator.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/input.h.s"
.include "sys/animations.h.s"
.include "sys/interruptions.h.s"

.include "cpctelera.h.s"

.globl cpct_getScreenPtr_asm

frame_counter:
    .db 0

points:
    .dw 1 ;; 2 bytes for many points

game_status:
    .db 0

sys_game_init:
    ; call    sys_interruptions_init
    call    man_entity_init
    call    sys_render_init
    ld      hl, #1
    ld      (points), hl ;; one point at start for avoid end the game early

    ld      a, #game_st_pause
    ld      (game_status), a ;; no finished, paused

    ;; create player and player attack
    call    man_player_create
    ; ld    ix, #player
    ; call  sys_render_update

    ret

sys_game_start:
    ;; maybe for testing: paint a mark where you can defeat enemies
    ld      c, #KILLING_ENEMIES_POS
    ld      b, #40
    ld      de, #0xC000
    call    cpct_getScreenPtr_asm
    ld      (hl), #0x11

    ;; ponemos a 0 el bit de pausa
    ; negamos la máscara
    ld      a, #game_st_pause
    neg
    ld      b, a
    ; hacemos AND con el estado para dejar a 0 únicamente el campo pausa
    ld      a, (game_status)
    and     b
    ld      (game_status), a
    ret

sys_game_pause:
    ld      a, (game_status)
    or      #game_st_pause
    ld      (game_status), a

    ;; y otras cosas como llamar al menú, etc.
    ret


;; checks if the game is finished
;; Return:
;;      a = 1 if game is finished, 0 if not
sys_game_check_finished:
    ld      a, (game_status)
    and     #game_st_finish
    jr      z, _not_finished
    ld      a, #1
    ret
 _not_finished:
    ld      a, #0
    ret


;; finish the game if points == 0
sys_game_finish:
    ld      hl, (points)
    ld      a, l
    cp      #0
    ret     nz

    ld      a, h
    cp      #0
    ret     nz

    ld      a, (game_status)
    or      #game_st_finish
    ld      (game_status), a
    ;;  exits from sys_game_play function if game is finished
    pop     hl
    ret

sys_game_inc_frames_counter:
    ld      a, (frame_counter)
    inc     a
    ld      (frame_counter), a
    ret

;; Input:
;;      bc = points to increase
sys_game_inc_points:
    ld      hl, (points)
    add     hl, bc
    ld      (points), hl
    ret

;; Input:
;;      No input needed
sys_game_dec_points:
    ld      hl, (points)
    dec     hl ;; only decrease points one by one
    ld      (points), hl
    ret


;; itarate one time over game loop
sys_game_play:
    ;; move enemies
    ld      hl,  #sys_physics_update
    call    man_enemy_forall

    ;; finish the game if equals to 0
    ;; (if game is finished exits from this function)
    call    sys_game_finish
   
    ;; move player and animate player attack
    call    sys_input_player_update
    ld      ix, #player
    call    sys_animation_update
    ld      ix, #player_attack
    ld      b, #7
    call    sys_animation_update_custom_speed

    ;; generate enemies
    call    sys_generator_update ; TODO
   
    ;; render enemies
    ld      hl,  #sys_render_update
    call    man_entity_forall

    ;; destroy dead enemies
    ld      hl, #man_enemy_destroy
    call    man_enemy_forall

    ;; increase game counter
    jr      sys_game_inc_frames_counter

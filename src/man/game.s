.include "game.h.s"
.include "man/entities.h.s"
.include "man/entity_templates.h.s"
.include "man/levels.h.s"
.include "sys/generator.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/input.h.s"
.include "sys/animations.h.s"
.include "sys/ia.h.s"

.include "cpctelera.h.s"

.globl cpct_getScreenPtr_asm

score: .asciz "SCORE: "

frame_counter:
    .db 0

points:
    .dw 1 ;; 2 bytes for many points

game_status:
    .db 0

sys_game_init:
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

    ;; reset enemies and points
    call    man_enemy_kill_all
    ld      a, #LANE1_Y
    ld      (target_player_position), a
    ld      hl, #1
    ld      (points), hl 

    ld      h, #00   ;; Set Background PEN to 0 (Black)
    ld      l, #04  ;; Set Foreground PEN to 4 (Red)
    call    cpct_setDrawCharM0_asm

    ld      c, #5                          ;; POS X
    ld      b, #0                           ;; POS Y
    ld      de, #0xC000
    call    cpct_getScreenPtr_asm

    ld iy, #score
    call cpct_drawStringM0_asm

    call print_hit_zone

    ld de, (points)
    call sys_print_score

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

    ;; y otras cosas como llamar al menú, etc.;;
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
    xor     a
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
    ld hl, (points)
    ld a, l
    add c
    daa                 ;;Ajusta para que cada grupo de 4 bits sea 0-9
    ld l, a
    ld a, h
    adc b               ;;Suma con acarreo
    daa
    ld h, a
    ld (points), hl

    ret

;; Decrease points by one
;; Input:
;;      No input needed
sys_game_dec_points:

    ld      hl, (points)
    ld      a, l
    sub     #1
    daa
    ld l, a
    ld a, h
    sbc #0
    ld h, a

    ld (points), hl

    ld bc, #1

    ret


;; itarate one time over game loop
sys_game_play:

    ;Aplicar ia
    ld      hl,  #ia_function
    call    man_enemy_forall

    ;; move enemies
    call    man_level_getSpeedRestriction
    ld      b, a
    ld      a, (frame_counter)
    and     b
    jr      nz, _no_physics_update
    ld      hl,  #sys_physics_update
    call    man_enemy_forall

    ;; finish the game if points == 0
    ;; (if game is finished exits from sys_game_play)
    call    sys_game_finish
   
 _no_physics_update:
    ;; check player input (move and attack)
    call    sys_input_player_update

    ;; player an attack animation update
    ld      ix, #player
    call    sys_animation_update
    ld      ix, #player_attack
    ld      b, #7
    call    sys_animation_update_custom_speed

    ;; generate enemies
    call    sys_generator_update 
   
    ld      a, (frame_counter)
    and     #1
    jr      z, _no_render
    ;; render enemies
    ld      hl,  #sys_render_update
    call    man_entity_forall

 _no_render:
    ;; destroy dead enemies
    ld      hl, #man_enemy_destroy
    call    man_enemy_forall

    ld de, (points)
    call sys_print_score

    ;; increase game counter
    jr      sys_game_inc_frames_counter

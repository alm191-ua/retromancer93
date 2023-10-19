.include "game.h.s"
.include "man/entities.h.s"
.include "man/entity_templates.h.s"
.include "sys/generator.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/input.h.s"
.include "sys/animations.h.s"

.include "cpctelera.h.s"

.globl cpct_getScreenPtr_asm

frame_counter:
    .db 0

points:
    .dw 0 ;; 2 bytes for many points

sys_game_init:
    call  man_entity_init
    call  sys_render_init
    ld    hl, #1
    ld    (points), hl ;; one point at start for avoid end the game early

    ;; create player and player attack
    call  man_player_create
    ; ld    ix, #player
    ; call  sys_render_update


    ;; maybe for testing: paint a mark where you can defeat enemies
    ld      c, #KILLING_ENEMIES_POS
    ld      b, #40
    ld      de, #0xC000
    call    cpct_getScreenPtr_asm
    ld      (hl), #0x11
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

sys_game_play:
    ld      hl,  #sys_physics_update
    call    man_enemy_forall
   
    call    sys_input_player_update
    ld      ix, #player
    call    sys_animation_update
    ld      ix, #player_attack
    ld      b, #7
    call    sys_animation_update_custom_speed

    ; call    sys_generator_update ; TODO
   
    ld      hl,  #sys_render_update
    call    man_entity_forall

    ld      hl, #man_enemy_destroy
    call    man_enemy_forall

    jr      sys_game_inc_frames_counter

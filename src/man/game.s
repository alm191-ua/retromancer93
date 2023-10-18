.include "game.h.s"
.include "man/entities.h.s"
.include "man/entity_templates.h.s"
.include "sys/generator.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/input.h.s"
.include "sys/animations.h.s"

.include "cpctelera.h.s"

frame_counter:
    .db 0

sys_game_init:
    call  man_entity_init
    call  sys_render_init
    ret

sys_game_inc_frames_counter:
    ld      a, (frame_counter)
    inc     a
    ld      (frame_counter), a
    ret

sys_game_play:
    ld      hl,  #sys_physics_update
    call    man_enemy_forall
   
    call    sys_input_player_update
    ld      ix, #player
    call    sys_animation_update
    ; call    sys_generator_update ; TODO
   
    ld      hl,  #sys_render_update
    call    man_entity_forall

    ld      hl, #man_enemy_destroy
    call    man_enemy_forall

    jr      sys_game_inc_frames_counter

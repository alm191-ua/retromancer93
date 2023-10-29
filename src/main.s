
.include "cpctelera.h.s"
.include "man/game.h.s"
.include "man/levels.h.s"

.include "man/entities.h.s"
.include "man/entity_templates.h.s"
.include "sys/render.h.s"
.include "man/menu.h.s"
.include "man/interruptions.h.s"

.area _DATA
string: .asciz "PRESS ANY BUTTON TO START"

.area _CODE

.globl cpct_disableFirmware_asm
.globl cpct_waitVSYNC_asm
.globl cpct_setDrawCharM0_asm
.globl cpct_drawStringM0_asm
.globl cpct_scanKeyboard_asm
.globl cpct_isAnyKeyPressed_asm

.globl _spr_alien_void

_wait:
   ; halt
   call  cpct_waitVSYNC_asm
   ret

retromancer:
   ;; INIT MANAGER AND RENDER

   ; ;; create player
   ; call  man_player_create
   ; ld    ix, #player
   ; call  sys_render_update

   ;; create enemy lane 1
   ; ld    ix, #tmpl_enemy_o
   ; call  man_enemy_create
   ; ld__ixh_d
   ; ld__ixl_e
   ; ld    a, e_x(ix)
   ; add   #-10
   ; ld    e_x (ix), a
   ; call  sys_render_update

   ; create enemy lane 2
  ;  ld    ix, #tmpl_enemy_p
  ;  call  man_enemy_create
  ;  ld__ixh_d
  ;  ld__ixl_e
  ;  ld    e_y (ix), #120 ;; move enemy to lane 2
  ;  call  sys_render_update
   
   ;;
   ;;MAIN LOOP
   ;;
   call  sys_game_start 
 _main_loop:
   call  sys_game_play
   call  sys_game_check_finished
   or    a
   jr    z, _continue_game

   ;; Shows victory or lost screen
   ;; TODO: Detectar si se ha ganado o perdido para enviar a la pantalla que toque

   or    a
   jr    z, _won
   jr    _lost

   jr    _game_init

 _continue_game:
   call _wait
   jr _main_loop

 _won:
   call   man_menu_victory

   call   man_level_unlock_next
   ld     a, #1
   call   man_level_set
   jr     _game_init 
 _lost:
   call   man_menu_failed
   ld     a, #1
   call   man_level_set
   jr _game_init
_main::
   ; call  cpct_disableFirmware_asm ;; / no hace falta porque en sys_game_init 
                                    ;; \ estamos sobrescribiendo el código de la interrupción
   call  man_interruptions_init

 _game_init:
   call  sys_game_init
   call  start_screen
   jr    retromancer

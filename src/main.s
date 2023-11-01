
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


_wait:
   ; halt
   call  cpct_waitVSYNC_asm
   ret

retromancer:
   
   ;;
   ;;MAIN LOOP
   ;;
   call  man_game_start 
 _main_loop:
   call  man_game_play
   call  man_game_check_finished
   or    a
   jr    z, _continue_game

   ;; Shows victory or lost screen
   ;; TODO: Detectar si se ha ganado o perdido para enviar a la pantalla que toque
   call  man_game_check_victory
   or    a
   jr    nz, _won      ;; Si cambias la nz por z, al perder "ganas". Probar ese pantalla se hace mas facil
   jr    _lost


 _continue_game:
   call _wait
   jr _main_loop

 _won:
   call   man_menu_victory
   
   call   man_level_unlock_next
   call   man_level_next          ;; RETURNED 1 IF GAME ENDED

   cp #1
   jr     z, _game_ended
   call  man_game_init
   jr     retromancer 
 _game_ended:
   ;;TODO: PANTALLA DE FINAL DE JUEGO
   ;;call   man_menu_end_screen
   jr   _game_init
 _lost:
   call   man_menu_failed
   ld     a, #1
   call   man_level_set
   jr _game_init
_main::
   ; call  cpct_disableFirmware_asm ;; / no hace falta porque en man_game_init 
                                    ;; \ estamos sobrescribiendo el código de la interrupción
   call  man_interruptions_init

 _game_init:
   call  man_game_init
   call  start_screen
   jr    retromancer

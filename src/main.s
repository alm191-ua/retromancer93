
.include "cpctelera.h.s"
.include "man/game.h.s"

.include "man/entities.h.s"
.include "man/entity_templates.h.s"
.include "sys/render.h.s"
.include "sys/menu.h.s"

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

   ;; create player
   call  man_player_create
   ld    ix, #player
   call  sys_render_update

   ;; create enemy lane 1
   ld    ix, #tmpl_enemy_void
   call  man_enemy_create
   ld__ixh_d
   ld__ixl_e
   call  sys_render_update

   ; create enemy lane 2
   ld    ix, #tmpl_enemy_p
   call  man_enemy_create
   ld__ixh_d
   ld__ixl_e
   ld    e_y (ix), #120 ;; move enemy to lane 2
   call  sys_render_update
   
   ;;
   ;;MAIN LOOP
   ;;
 _main_loop:
   call sys_game_play

   call _wait
   jr _main_loop

_main::
   call  cpct_disableFirmware_asm
   call sys_game_init
   call start_screen
   jr    retromancer

.include "cpctelera.h.s"
.include "man/game.h.s"

.include "man/entities.h.s"
.include "man/entity_templates.h.s"
.include "sys/render.h.s"

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

start_screen:


   ld   h, #00   ;; Set Background PEN to 0 (Black)
   ld   l, #04  ;; Set Foreground PEN to 3 (Blue)

   call cpct_setDrawCharM0_asm ;; Set up colours for drawn characters in mode 0

   ;; We are going to call draw String, and we have to push parameters
   ;; to the stack first (as the function recovers it from there).
   ld   iy, #string ;; IY = Pointer to the start of the string
   ld   hl, #0xC280  ;; HL = Pointer to video memory location where the string will be drawn

   call cpct_drawStringM0_asm ;; Call the string drawing function

   loop_start_game:
      call    cpct_scanKeyboard_asm
      call    cpct_isAnyKeyPressed_asm
      jr nz, exit_loop_game
      jr loop_start_game

   exit_loop_game:
      ld   h, #00   ;; Set Background PEN to 0 (Black)
      ld   l, #00  ;; Set Foreground PEN to 3 (Blue)

      call cpct_setDrawCharM0_asm ;; Set up colours for drawn characters in mode 0

      ;; We are going to call draw String, and we have to push parameters
      ;; to the stack first (as the function recovers it from there).
      ld   iy, #string ;; IY = Pointer to the start of the string
      ld   hl, #0xC280  ;; HL = Pointer to video memory location where the string will be drawn

      call cpct_drawStringM0_asm ;; Call the string drawing function
      jr retromancer


retromancer:
   ;; INIT MANAGER AND RENDER

   ; ;; create player
   ; call  man_player_create
   ; ld    ix, #player
   ; call  sys_render_update

   ;; create enemy lane 1
   ld    ix, #tmpl_enemy_o
   call  man_enemy_create
   ld__ixh_d
   ld__ixl_e
   ld    a, e_x(ix)
   add   #-10
   ld    e_x (ix), a
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
   call  sys_game_init
   jr    start_screen
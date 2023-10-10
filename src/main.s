
.include "cpctelera.h.s"
.include "man/entities.h.s"
.include "sys/render.h.s"
.include "man/entity_templates.h.s"
.include "sys/physics.h.s"
.include "sys/input.h.s"

.area _DATA
.area _CODE

.globl cpct_disableFirmware_asm
.globl cpct_waitVSYNC_asm
.globl cpct_getScreenPtr_asm
.globl cpct_drawSprite_asm
.globl cpct_setVideoMode_asm
.globl _g_palette
.globl cpct_setPalette_asm

.globl _spr_alien_void

.macro SysUpdate sysname
   ld    hl, #sys_'sysname'_update
   call  man_entity_forall
.endm

_wait:
   ; halt
   call  cpct_waitVSYNC_asm
   ret

retromancer:
   ;; INIT MANAGER AND RENDER

   call  man_entity_init
   call  sys_render_init

   ;; player
   ld    ix, #tmpl_player
   call  man_enemy_create
   ld__ixh_d
   ld__ixl_e
   call  sys_render_update

   ;; enemy lane 1
   ld    ix, #tmpl_enemy_void
   call  man_enemy_create
   ld__ixh_d
   ld__ixl_e
   call  sys_render_update

   ; enemy lane 2
   ld    ix, #tmpl_enemy_void
   call  man_enemy_create
   ld__ixh_d
   ld__ixl_e
   ld    e_y (ix), #120
   call  sys_render_update
   
   ;;
   ;;MAIN LOOP
   ;;
 _main_loop:
   ; ld    hl,  #sys_physics_update      ;; / For testing, 
   ; call  man_enemy_forall
   
   ; call  sys_input_player_update ;; |
   
   ; ld    hl,  #sys_render_update       ;; \ only works with one entity
   ; call  man_enemy_forall
   call sys_physics_update
   call sys_input_player_update
   call sys_render_update

   ; Update Systems
   ;SysUpdate physics
   ;call sys_generator_update
   ; SysUpdate generator
   ;SysUpdate render
   ; Update Entity Manager
   ;call man_entity_update

   call _wait
   jr _main_loop

_main::

   call  cpct_disableFirmware_asm
   jr    retromancer

.include "cpctelera.h.s"
.include "man/entities.h.s"
.include "sys/render.h.s"
.include "man/entity_templates.h.s"

.area _DATA

.area _CODE

.globl cpct_disableFirmware_asm
.globl cpct_waitVSYNC_asm
.globl _spr_alien_void
.globl cpct_getScreenPtr_asm
.globl cpct_drawSprite_asm
.globl cpct_setVideoMode_asm
.globl _g_palette
.globl cpct_setPalette_asm

.macro SysUpdate sysname
   ld    hl, #sys_'sysname'_update
   call  man_entity_forall
.endm

_wait:
   ; halt
   ; halt
   call  cpct_waitVSYNC_asm
   ret

retromancer:
   ;; INIT MANAGER AND RENDER

   call man_entity_init
   call sys_render_init

   ld hl, #tmpl_enemy_void
   call man_entity_create

   call sys_render_update
   
   ;;
   ;;MAIN LOOP
   ;;
 _main_loop:
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
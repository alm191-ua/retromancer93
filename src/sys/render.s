.include "render.h.s"
.include "man/entities.h.s"


.include "cpctelera.h.s"

.globl cpct_getScreenPtr_asm
.globl cpct_drawSprite_asm
.globl cpct_setVideoMode_asm
.globl _g_palette
.globl cpct_setPalette_asm


sys_render_init:
    ld      c, #0
    call    cpct_setVideoMode_asm
    ld hl, #_g_palette
    ld de, #16
    call cpct_setPalette_asm
    cpctm_setBorder_asm HW_BLACK

    ret


;;
;; UPDATE
;;      Renders an entity
;; Input
;;      IX: Entity to be rendered
;;
sys_render_update::
    
    ld de, #0xC000
    ld a, e_x(ix)
    ld c, a
    ld a, e_y(ix)
    ld b, a
    call cpct_getScreenPtr_asm
    ex de, hl
    ld h, e_sprite+1(ix)
    ld l, e_sprite(ix)
    ld b, e_h(ix)
    ld c, e_w(ix)
    call cpct_drawSprite_asm
    ret



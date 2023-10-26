.include "render.h.s"
.include "man/entities.h.s"

.include "cpctelera.h.s"

sys_render_init:
    ld      c, #0
    call    cpct_setVideoMode_asm

    ld      hl, #_g_palette
    ld      de, #16
    call    cpct_setPalette_asm

    cpctm_setBorder_asm HW_BLACK

    ret


;;
;; UPDATE
;;      Renders an entity
;; Input
;;      IX: Entity to be rendered
;;
sys_render_update::
    ;; check render bit
    ld      a, e_comp (ix)
    and     #e_cmp_render
    ret     z
    
    ld      de, #0xC000
    ld      a, e_x(ix)
    ld      c, a
    ld      a, e_y(ix)
    ld      b, a
    call    cpct_getScreenPtr_asm
    ex      de, hl
    
    ld      l, e_sprite  (ix)
    ld      h, e_sprite+1(ix)
    ld      b, e_h(ix)
    ld      c, e_w(ix)
    call    cpct_drawSprite_asm

    ret

print_hit_zone::
    ;; maybe for testing: paint a mark where you can defeat enemies
    ld      c, #KILLING_ENEMIES_POS-4
    ld      b, #24
    ld      de, #0xC000
    call    cpct_getScreenPtr_asm
    ex de, hl
    ld hl, #_spr_marcador_0
    ld      c, #4
    ld      b, #16
    call cpct_drawSprite_asm

    ld      c, #KILLING_ENEMIES_POS-4
    ld      b, #156
    ld      de, #0xC000
    call    cpct_getScreenPtr_asm
    ex de, hl
    ld hl, #_spr_marcador_1
    ld      c, #4
    ld      b, #16
    call cpct_drawSprite_asm
    ret

    ; ld      h, #00   ;; Set Background PEN to 0 (Black)
    ; ld      l, #04  ;; Set Foreground PEN to 4 (Red)
    ; call    cpct_setDrawCharM0_asm

    ; ld      c, #5                          ;; POS X
    ; ld      b, #0                           ;; POS Y
    ; ld      de, #0xC000
    ; call    cpct_getScreenPtr_asm

    ; ld iy, #score
    ; call cpct_drawStringM0_asm

;;
;; INPUT
;;
;; c: POS X
;; b: POS Y
;;
_get_screen_ptr:
    ld      de, #0xC000
    call    cpct_getScreenPtr_asm
    ret

;;
;; DEVUELVE EL CARACTER ASCII DEL NUMERO
;;
;; INPUT
;;
;; A: Number
;;
_get_ascii_char:

    and #0x0F
    add #48
    ld e, a
    ret

;;
;; INPUT
;;
;; DE: POINTS
sys_print_score::

    push de

    ld      h, #00   ;; Set Background PEN to 0 (Black)
    ld      l, #05  ;; Set Foreground PEN to 4 (Red)
    call    cpct_setDrawCharM0_asm

    ld c, #30
    ld b, #0
    call _get_screen_ptr

    pop de
    ld a, d
    rra
    rra
    rra
    rra
    push de
    call _get_ascii_char
    call cpct_drawCharM0_asm

    ld c, #35
    ld b, #0
    call _get_screen_ptr

    pop de
    ld a, d
    push de
    call _get_ascii_char
    call cpct_drawCharM0_asm

    ld c, #40
    ld b, #0
    call _get_screen_ptr

    pop de
    ld a, e
    rra
    rra
    rra
    rra
    push de
    call _get_ascii_char
    call cpct_drawCharM0_asm

    ld c, #45
    ld b, #0
    call _get_screen_ptr

    pop de

    ld a, e
    call _get_ascii_char
    call cpct_drawCharM0_asm

    
    

    ret
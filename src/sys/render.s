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

sys_render_print_shield:
    ld      c, #KILLING_ENEMIES_POS-10
    ld      b, #30
    ld      de, #0xC000
    call    cpct_getScreenPtr_asm
    ex de, hl
    ld hl, #_spr_barrera
    ld      c, #3
    ld      b, #110
    call cpct_drawSprite_asm

    ld      c, #POS_X_PLAYER
    ld      b, #LANE1_Y+15
    ld      de, #0xC000
    call    cpct_getScreenPtr_asm
    ex de, hl
    ld hl, #_spr_player_0
    ld      c, #8
    ld      b, #32
    call cpct_drawSprite_asm

    ret

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
sys_render_defeat_modify_tilemap:
   

    ld      de, #0xC000
    ld      c, #8
    ld      b, #24
    call    cpct_getScreenPtr_asm

    ex      de, hl

    ld      hl, #_spr_tiles_derrota_3
    ld      c, #8
    ld      b, #8
    call    cpct_drawSprite_asm


    ld      de, #0xC000
    ld      c, #8
    ld      b, #32
    call    cpct_getScreenPtr_asm

    ex      de, hl

    ld      hl, #_spr_tiles_derrota_5
    ld      c, #8
    ld      b, #8
    call    cpct_drawSprite_asm

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ld      de, #0xC000
    ld      c, #148
    ld      b, #152
    call    cpct_getScreenPtr_asm

    ex      de, hl

    ld      hl, #_spr_tiles_derrota_3
    ld      c, #8
    ld      b, #8
    call    cpct_drawSprite_asm


    ld      de, #0xC000
    ld      c, #148
    ld      b, #160
    call    cpct_getScreenPtr_asm

    ex      de, hl

    ld      hl, #_spr_tiles_derrota_5
    ld      c, #8
    ld      b, #8
    call    cpct_drawSprite_asm

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,

    ld      de, #0xC000
    ld      c, #64
    ld      b, #8
    call    cpct_getScreenPtr_asm

    ex      de, hl

    ld      hl, #_spr_tiles_derrota_2
    ld      c, #8
    ld      b, #8
    call    cpct_drawSprite_asm


    ld      de, #0xC000
    ld      c, #64
    ld      b, #16
    call    cpct_getScreenPtr_asm

    ex      de, hl

    ld      hl, #_spr_tiles_derrota_4
    ld      c, #8
    ld      b, #8
    call    cpct_drawSprite_asm
    ;;;;
    ld      de, #0xC000
    ld      c, #12
    ld      b, #152
    call    cpct_getScreenPtr_asm

    ex      de, hl

    ld      hl, #_spr_tiles_derrota_2
    ld      c, #8
    ld      b, #8
    call    cpct_drawSprite_asm


    ld      de, #0xC000
    ld      c, #12
    ld      b, #160
    call    cpct_getScreenPtr_asm

    ex      de, hl

    ld      hl, #_spr_tiles_derrota_4
    ld      c, #8
    ld      b, #8
    call    cpct_drawSprite_asm



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ld      de, #0xC000
    ld      c, #26
    ld      b, #190
    call    cpct_getScreenPtr_asm

    ex      de, hl

    ld      hl, #_spr_tiles_derrota_0
    ld      c, #8
    ld      b, #8
    call    cpct_drawSprite_asm

    ld      de, #0xC000
    ld      c, #40
    ld      b, #180
    call    cpct_getScreenPtr_asm

    ex      de, hl

    ld      hl, #_spr_tiles_derrota_1
    ld      c, #8
    ld      b, #8
    call    cpct_drawSprite_asm

    ld      de, #0xC000
    ld      c, #10
    ld      b, #69
    call    cpct_getScreenPtr_asm

    ex      de, hl

    ld      hl, #_spr_player_defeat
    ld      c, #8
    ld      b, #32
    call    cpct_drawSprite_asm


    ret

sys_render_tilemap::

    ; (1B C) width	Width in tiles of the view window to be drawn
    ; (1B B) height	Height in tiles of the view window to be drawn
    ; (2B DE) tilemapWidth	Width in tiles of the complete tilemap
    ; (2B HL) tileset	Pointer to the start of the tileset definition (list of 32-byte tiles).

    ld      bc, #0x1914                  ;Mapa de 25x20 tiles
    ld      de, #0x0014
    ld      hl, #_tiles_mapa_00

    call cpct_etm_setDrawTilemap4x8_ag_asm

    ; (2B HL) memory	Video memory location where to draw the tilemap (character & 4-byte aligned)
    ; (2B DE) tilemap	Pointer to the upper-left tile of the view to be drawn of the tilemap
    ld      hl, #0xC000
    ld      de, #_tilemap_01
    call cpct_etm_drawTilemap4x8_ag_asm

    ret
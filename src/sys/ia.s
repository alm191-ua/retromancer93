.include "ia.h.s"
.include "man/entities.h.s"             ;CAMBIAR
.include "man/entity_templates.h.s"
.include "man/levels.h.s"
.include "cpctelera.h.s"

;Cambiar enemy create
;Cambiar game.s
;Hacer una probabilidad de que cambie de fila  a no ser que esté cerca del final

;ld      a, e_comp (ix)
;or      #e_cmp_set4dead
;ld      e_comp (ix), a

;ld      a, e_type (ix)
;cp      #type_enemy_void
;jr      z, _kill_enemy

;32 pixeles

;; updates the AI for one entity
;; Input:
;;      IX = entity to update its AI
sys_ia_update:
    ld      a, e_comp (ix)
    and     #e_cmp_ia
    cp      #0
    ret     z ;; do not update

    ;; get AI function
    ld      l, e_ia  (ix)
    ld      h, e_ia+1(ix)
    ;; call AI function
    ld      (_func), hl
 _func = .+1
    call    (_func)

    ret


ia_teleport:

    ;Si está muy cerca no se aplica la ia
    suficientemente_lejos:  
    ld      a, e_x(ix) 
    sub     a, #32
    jr      nc, aplicar_ia
    ret

    ;Aplica el random para ver si salta de linea
    aplicar_ia:
    ld      b, #0x3F
    call    random
    cp      #0
    jr      z, continuar_ia
    ret

    ;Salta de linea
    continuar_ia:
    ld      de, #0xC000
    ld      a, e_x(ix)
    ld      c, a
    ld      a, e_y(ix)
    ld      b, a
    call    cpct_getScreenPtr_asm
    ex      de, hl
    ld hl, #_spr_alien_void_5
    ld      c, #10
    ld      b, #32
    call cpct_drawSprite_asm

    ld a, e_y (ix)
    cp #LANE1_Y
    jr z, cambiar_lin_2
    ld    e_y (ix), #LANE1_Y
    jr cont_ia
    
    cambiar_lin_2:
    ld    e_y (ix), #LANE2_Y

    cont_ia:
    ret


random:
        call cpct_getRandom_xsp40_u8_asm
        and a, b
        ;ld hl, #0xC000
        ;ld (hl), a
        ret
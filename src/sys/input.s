.include "input.h.s"
.include "man/entities.h.s"
.include "cpctelera.h.s"

.globl cpct_scanKeyboard_asm
.globl cpct_isAnyKeyPressed_asm
.globl cpct_isKeyPressed_asm


;; do something to the entity if is marked as e_cmp_input
;; Input:
;;      IX = entity to do something with
sys_input_player_update:
    ;; check input component
    ld      a, e_comp (ix)
    and     #e_cmp_input
    ret     z

    call    cpct_scanKeyboard_asm
    call    cpct_isAnyKeyPressed_asm
    ret     z
    
    ;; check O
    ld      hl, #Key_O
    call    cpct_isKeyPressed_asm
    jr      nz, _O_pressed
    ;; check P
    ld      hl, #Key_P
    call    cpct_isKeyPressed_asm
    jr      nz, _P_pressed
    ;; check Q
    ld      hl, #Key_Q
    call    cpct_isKeyPressed_asm
    jr      nz, _Q_pressed
    ;; check A
    ld      hl, #Key_A
    call    cpct_isKeyPressed_asm
    jr      nz, _A_pressed

    ret  ;; other key pressed

_O_pressed:
    ;; TODO: attack enemy (type O)
    ret

_P_pressed:
    ;; TODO: attack enemy (type P)
    ret

_Q_pressed:
    ;; move to the up lane
    ;; TODO: erase the previous sprite,
    ;; maybe with an invisible player that mirror the actual player
    ld      a, #LANE1_Y
    ld      e_y (ix), a
    ret

_A_pressed:
    ;; move to the bottom lane
    ld      a, #LANE2_Y
    ld      e_y (ix), a
    ret
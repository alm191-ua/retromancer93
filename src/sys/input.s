.include "input.h.s"
.include "man/entities.h.s"
.include "render.h.s"
.include "cpctelera.h.s"
.include "animations.h.s"

.globl cpct_scanKeyboard_asm
.globl cpct_isAnyKeyPressed_asm
.globl cpct_isKeyPressed_asm


;; do something to the entity if is marked as e_cmp_input
;; Input:
;;  NO INPUT NEEDED, ONLY WORKS WITH THE PLAYER
sys_input_player_update:
    ; ;; check input component
    ; ld      a, e_comp (ix)
    ; and     #e_cmp_input
    ; ret     z

    ; get player
    ld      ix, #player

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
    ;; move to the bottom lane
    ld e_anim_counter(ix), #0
    ld e_anim(ix), #player_tp_anim
    ld hl, #target_player_position
    ld (hl), #LANE1_Y-8
    ret
_A_pressed:
    ;; move to the bottom lane
    ld e_anim_counter(ix), #0
    ld e_anim(ix), #player_tp_anim
    ld hl, #target_player_position
    ld (hl), #LANE2_Y-8
    ret
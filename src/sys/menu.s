
.include "cpctelera.h.s"
.include "menu.h.s"

.area _DATA
welcome: .asciz "WELCOME TO... "
welcome2: .asciz "RETROMANCER"
press_Q: .asciz "PRESS Q: START GAME" 
press_A: .asciz "PRESS A: TUTORIAL"

.area _CODE

;;
;; INPUTs
;; c:   Coordinate x
;; b:   Coordinate y
;; iy:  Pointer to the start of the string
;;
print_text:
    ld de, #0xC000
    call cpct_getScreenPtr_asm          ;;Sets in HL the pointer to the x-y position
    call cpct_drawStringM0_asm
    ret

print_main_menu:
    ld c, #15
    ld b, #15
    ld iy, #welcome

    call print_text

    ld c, #15
    ld b, #25
    ld iy, #welcome2

    call print_text

    ld c, #0
    ld b, #55
    ld iy, #press_Q

    call print_text

    ld c, #0
    ld b, #65
    ld iy, #press_A

    call print_text
    ret

start_screen:

    ld   h, #00   ;; Set Background PEN to 0 (Black)
    ld   l, #04  ;; Set Foreground PEN to 3 (Red)
    call cpct_setDrawCharM0_asm
    call print_main_menu


 _loop_start_game:
    
    call    cpct_scanKeyboard_asm
    call    cpct_isAnyKeyPressed_asm
    jr z, _loop_start_game
    
    ;; check Q - Start game
    ld      hl, #Key_Q
    call    cpct_isKeyPressed_asm
    jr      nz, _Q_pressed
    ;; check A
    ld      hl, #Key_A
    call    cpct_isKeyPressed_asm
    jr      nz, _A_pressed

    jr _loop_start_game  ;; other key pressed

 _Q_pressed:
    ld   h, #00   ;; Set Background PEN to 0 (Black)
    ld   l, #00  ;; Set Foreground PEN to 3 (Blue)
    call cpct_setDrawCharM0_asm
    
    call print_main_menu
    
    ret

 _A_pressed:
    jr _Q_pressed
    
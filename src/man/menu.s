
.include "cpctelera.h.s"
.include "menu.h.s"
.include "sys/animations.h.s"

.area _DATA
welcome: .asciz "WELCOME TO... "
welcome2: .asciz "RETROMANCER"
press_Q: .asciz "PRESS Q: START GAME" 
press_A: .asciz "PRESS A: TUTORIAL"

tutorial: .asciz "TUTORIAL:"
t_movement_Q: .asciz "Press Q: Move UP"
t_movement_A: .asciz "Press A: Move DOWN"
t_keys_to_kill1: .asciz "Press the correct "
t_keys_to_kill2: .asciz "key to kill enemies"
t_kill_O: .asciz "PRESS O:"
t_kill_P: .asciz "PRESS P:"
t_space_key: .asciz "PRESS SPACE: KILL ALL ENEMIES WITH... "

tutorial_sprites:
    .dw _spr_alien_o_0
    .dw _spr_alien_p_0
    .dw _spr_alien_void_0
    .dw _spr_caldero_0

tutorial_black_sprites:
    .dw _spr_alien_o_5
    .dw _spr_alien_p_5
    .dw _spr_alien_void_5
    .dw _spr_caldero_3

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

print_tutorial:

    ld c, #20
    ld b, #85
    ld iy, #tutorial
    call print_text

    ld c, #0
    ld b, #95
    ld iy, #t_movement_Q
    call print_text

    ld c, #0
    ld b, #105
    ld iy, #t_movement_A
    call print_text

    ld c, #0
    ld b, #125
    ld iy, #t_keys_to_kill1
    call print_text
    ld c, #0
    ld b, #135
    ld iy, #t_keys_to_kill2
    call print_text

    ld c, #0
    ld b, #145
    ld iy, #t_kill_O
    call print_text

    ld c, #40
    ld b, #145
    ld iy, #t_kill_P
    call print_text

    ret

;;
;; INPUTs
;; ix: array with sprites to print
;;
print_tutorial_sprites:
    ld h, 0+1(ix)
    ld l, 0(ix)
    ld d, #10
    ld e, #32
    ld c, #0
    ld b, #153
    call print_enemie_sprite

    ld h, 4+1(ix)
    ld l, 4(ix)
    ld d, #10
    ld e, #32
    ld c, #10
    ld b, #153
    call print_enemie_sprite

    ld h, 6+1(ix)
    ld l, 6(ix)
    ld d, #10
    ld e, #32
    ld c, #20
    ld b, #153
    call print_enemie_sprite

    ld h, 2+1(ix)
    ld l, 2(ix)
    ld d, #10
    ld e, #32
    ld c, #40
    ld b, #153
    call print_enemie_sprite

    ld h, 4+1(ix)
    ld l, 4(ix)
    ld d, #10
    ld e, #32
    ld c, #50
    ld b, #153
    call print_enemie_sprite

    ld h, 6+1(ix)
    ld l, 6(ix)
    ld d, #10
    ld e, #32
    ld c, #60
    ld b, #153
    call print_enemie_sprite

    ret

;;
;;  INPUTs
;;
;;  HL: Sprite
;;  D:  Width
;;  E:  Height
;;  C:  X
;;  B:  Y
print_enemie_sprite:

    push hl
    push de    

    ld de, #0xC000
    call cpct_getScreenPtr_asm
    pop de
                ;; /
    ld c, d     ;; | BC contains width and height of the sprite
    ld b, e     ;; \
    ex de, hl   ;; DE contains pointer to video memory
    pop hl      ;; HL contains ponter to sprite

    call cpct_drawSprite_asm

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

delete_screen:
    ld      de, #0xC000
    xor     a       ;; background - black
    ld      c, #64  ;; width
    ld      b, #200 ;; heigth
    call    cpct_drawSolidBox_asm

    ld      de, #0xC040
    xor     a       ;; background - black
    ld      c, #64  ;; width
    ld      b, #200 ;; heigth
    call    cpct_drawSolidBox_asm
    ret
start_screen:
    ;; select the menu song to reproduce
    ; ld      de, #_song_menu
    ; call    cpct_akp_musicInit_asm

    call delete_screen

    ld      h, #00   ;; Set Background PEN to 0 (Black)
    ld      l, #04  ;; Set Foreground PEN to 4 (Red)
    call    cpct_setDrawCharM0_asm
    call    print_main_menu


 _loop_start_game:
    
    ; call    cpct_scanKeyboard_asm ; ya se hace en las interrupciones
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

    ;;Print levels
    call delete_screen
    ; call cpct_akp_stop_asm

    ret

 _A_pressed:
    ld   h, #00   ;; Set Background PEN to 0 (Black)
    ld   l, #06  ;; Set Foreground PEN to 3 (Red)
    call cpct_setDrawCharM0_asm
    call print_tutorial
    ld ix, #tutorial_sprites
    call print_tutorial_sprites
    jr _loop_start_game
    
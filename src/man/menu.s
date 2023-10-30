
.include "cpctelera.h.s"
.include "menu.h.s"
.include "sys/animations.h.s"
.include "man/levels.h.s"

.area _DATA
welcome: .asciz "WELCOME TO... "
welcome2: .asciz "RETROMANCER"
press_Q: .asciz "Q: SELECT LEVEL" 
press_A: .asciz "A: SHOW TUTORIAL"

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

levels_select: .asciz "SELECT A LEVEL"
levels_guide1: .asciz "Q/A: UP/DOWN"
levels_guide2: .asciz "O: ACCEPT"

level1:    .asciz "LEVEL 1 (Tutorial)"
level2:    .asciz "LEVEL 2 (Easy)"
level3:    .asciz "LEVEL 3 (Normal)"
level4:    .asciz "LEVEL 4 (Hard)"
level5:    .asciz "LEVEL 5 (Secret?)"
derrota:    .asciz "YOU LOST :C"
victoria1:   .asciz "YOU WON!!"
victoria2:  .asciz "NEXT LEVEL UNLOCKED"
victoria3:  .asciz "THE RETROVERSE IS SAFE"
press_O_to_return:   .asciz "O: BACK TO MAIN MENU"

selected_level:
    .db 1
cursor_position:
    .db #60

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

    ld c, #5
    ld b, #55
    ld iy, #press_Q

    call print_text

    ld c, #5
    ld b, #65
    ld iy, #press_A

    call print_text
    ret

change_color_to_locked::

    ld hl, #unlocked_levels
    ld a, (hl)

    and b
    jr nz, _end

    ld   h, #00   ;; Set Background PEN to 0 (Black)
    ld   l, #8  ;; Set Foreground PEN to 8 (Grey)
    call cpct_setDrawCharM0_asm
 _end:    
    ret

print_level_selection_menu:

    ld c, #13
    ld b, #15
    ld iy, #levels_select
    call print_text

    ld   h, #00   ;; Set Background PEN to 0 (Black)
    ld   l, #06  ;; Set Foreground PEN to 6 (BLUE)
    call cpct_setDrawCharM0_asm

    ld c, #15
    ld b, #30
    ld iy, #levels_guide1
    call print_text
    ld c, #15
    ld b, #40
    ld iy, #levels_guide2
    call print_text

    ld   h, #00   ;; Set Background PEN to 0 (Black)
    ld   l, #10  ;; Set Foreground PEN to 10 (Pink?)
    call cpct_setDrawCharM0_asm

    ld c, #5
    ld b, #60
    ld iy, #level1
    call print_text

    ld b, #level_2                ;level_2 contains the bit to check if the level 2 is unlocked
    call change_color_to_locked

    ld c, #5
    ld b, #80
    ld iy, #level2
    call print_text

    ld b, #level_3                  ;level_3 contains the bit cho check if the level 2 is unlocked
    call change_color_to_locked

    ld c, #5
    ld b, #100
    ld iy, #level3
    call print_text

    ld b, #level_4                  ;level_2 contains the bit cho check if the level 2 is unlocked
    call change_color_to_locked

    ld c, #5
    ld b, #120
    ld iy, #level4
    call print_text

    ld b, #level_5                  ;level_2 contains the bit cho check if the level 2 is unlocked
    call change_color_to_locked

    ld c, #5
    ld b, #140
    ld iy, #level5
    call print_text

    ret

;;
;;  INPUT
;;
;;  h = Background color
;;  l = Foreground color
;;
print_selection_cursor:

    push bc

    call    cpct_setDrawCharM0_asm

    pop bc

    ld hl, (cursor_position)
    ld b, l

    ld de, #0xC000
    ld c, #0
    call cpct_getScreenPtr_asm          ;;Sets in HL the pointer to the x-y position

    ld e, #62
    call cpct_drawCharM0_asm            ;; Prints ">"

    ret
    

ClearKeyboardBuffer:
    call    cpct_isAnyKeyPressed_asm  ; Check if any key is pressed
    ret z                             ; If no key is pressed, return

    call    cpct_scanKeyboard_asm          ; Read and discard the key
    jr      ClearKeyboardBuffer       ; Recursively clear the buffer

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

level_selection::

    ld      hl, #cursor_position
    ld      (hl), #60
    ld      hl, #selected_level
    ld      (hl), #1

    call delete_screen

    ld      h, #00   ;; Set Background PEN to 0 (Black)
    ld      l, #04  ;; Set Foreground PEN to 4 (Red)
    call    cpct_setDrawCharM0_asm
    call    print_level_selection_menu

    ld      h, #00
    ld      l, #15
    call print_selection_cursor


 _loop_level_selection:
    
    ;call ClearKeyboardBuffer

    ; call    cpct_scanKeyboard_asm ; ya se hace en las interrupciones
    call    cpct_isAnyKeyPressed_asm
    jr z, _loop_level_selection
    
    ;; check Q - Start game
    ld      hl, #Key_Q
    call    cpct_isKeyPressed_asm
    jr      nz, _Q
    ;; check A
    ld      hl, #Key_A
    call    cpct_isKeyPressed_asm
    jr      nz, _A

    ;; check O
    ld      hl, #Key_O
    call    cpct_isKeyPressed_asm
    jr      nz, _O

    jr _loop_level_selection  ;; other key pressed

 _O:
    
    ;;Checks if level is unlocked

    ld      a, (unlocked_levels)   ; Load the bitfield into register A
    ld      hl, #selected_level   ; Load the selected level number into register B
    ld      b, (hl)

    djnz    _keep_checking
    jr      _CheckLevelUnlocked

 _keep_checking:
    rra
    djnz    _keep_checking                  ; If B is not zero, jump to the next SLL instruction

 _CheckLevelUnlocked:
; Level is unlocked, handle accordingly
    bit     0, a                            ; Checks if the level is unlocked
    jr      z, _loop_level_selection        ; If the selected leves is not unlocked keeps looping
    ld      a, (selected_level)             ; /
    call    man_level_set                   ; | Sets te level, clears the screen and the keyboard buffer.
    call    delete_screen                   ; | Then starts the level
    call    ClearKeyboardBuffer             ; \
    ret

 _Q:

    ; ld      hl, #Key_Q
    ; call    cpct_isKeyPressed_asm
    ; jp      nz, _loop_level_selection
    call ClearKeyboardBuffer
    ld      hl, (selected_level)
    ld      a, l
    sub     #1

    or      a
    jr      z, _loop_level_selection

    ld      hl, #selected_level
    ld      (hl), a                      ;; Saves the level selected

    ld      hl, (cursor_position)
    ld      a, l
    sub     #20                         ;; Calculates new position for the cursor
    push    af

    ld      h, #00                  ;; /
    ld      l, #00                  ;; | Deletes the last position of the cursor
    call    print_selection_cursor  ;; \

    pop     af

    ld      hl, #cursor_position
    ld      (hl), a                 ;; Saves new position of cursor

    ld      h, #00                  ;; /
    ld      l, #15                  ;; | Prints cursor
    call    print_selection_cursor  ;; \
    
    halt

    jr _loop_level_selection
 _loop_level_selection1:
    jr _loop_level_selection
 _A:

    ; ld      hl, #Key_A
    ; call    cpct_isKeyPressed_asm
    ; jp      nz, _loop_level_selection
    call ClearKeyboardBuffer
    ld      hl, (selected_level)
    ld      a, l
    add     #1

    cp      #6
    jr      z, _loop_level_selection

    ld      hl, #selected_level
    ld      (hl), a                      ;; Saves the level selected

    ld      hl, (cursor_position)
    ld      a, l
    add     #20                         ;; Calculates new position for the cursor
    push    af

    ld      h, #00                  ;; /
    ld      l, #00                  ;; | Deletes the last position of the cursor
    call    print_selection_cursor  ;; \

    pop     af
    ld      hl, #cursor_position
    ld      (hl), a                 ;; Saves new position of cursor

    ld      h, #00                  ;; /
    ld      l, #15                  ;; | Prints cursor
    call    print_selection_cursor  ;; \

    jr _loop_level_selection1
    
man_menu_victory:

    call delete_screen

    ld   h, #00   ;; Set Background PEN to 0 (Black)
    ld   l, #04  ;; Set Foreground PEN to 6 (RED)
    call cpct_setDrawCharM0_asm

    ld c, #20
    ld b, #30
    ld iy, #victoria1
    call print_text

    ld c, #3
    ld b, #50
    ld iy, #victoria2
    call print_text

    ld   h, #00   ;; Set Background PEN to 0 (Black)
    ld   l, #06  ;; Set Foreground PEN to 6 (BLUE)
    call cpct_setDrawCharM0_asm

    ld c, #0
    ld b, #80
    ld iy, #press_O_to_return
    call print_text

 _loop_v:
    call    cpct_isAnyKeyPressed_asm
    jr z, _loop_v
    
    ;; check O
    ld      hl, #Key_O
    call    cpct_isKeyPressed_asm
    jr      nz, _O_victory

    jr _loop_v  ;; other key pressed

 _O_victory:

    call ClearKeyboardBuffer

    ret

man_menu_failed:

    call delete_screen

    ld   h, #00   ;; Set Background PEN to 0 (Black)
    ld   l, #04  ;; Set Foreground PEN to 6 (RED)
    call cpct_setDrawCharM0_asm

    ld c, #20
    ld b, #30
    ld iy, #derrota
    call print_text


    ld   h, #00   ;; Set Background PEN to 0 (Black)
    ld   l, #06  ;; Set Foreground PEN to 6 (BLUE)
    call cpct_setDrawCharM0_asm

    ld c, #0
    ld b, #50
    ld iy, #press_O_to_return
    call print_text

 _loop_f:
    call    cpct_isAnyKeyPressed_asm
    jr z, _loop_f
    
    ;; check O
    ld      hl, #Key_O
    call    cpct_isKeyPressed_asm
    jr      nz, _O_failed

    jr _loop_f  ;; other key pressed

 _O_failed:

    call ClearKeyboardBuffer

    ret

start_screen:
    ;; select the menu song to reproduce
    ld      de, #_song_menu
    call    cpct_akp_musicInit_asm

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
    call level_selection
    ; call cpct_akp_stop_asm

    ret

 _A_pressed:
    ld   h, #00   ;; Set Background PEN to 0 (Black)
    ld   l, #06  ;; Set Foreground PEN to 6 (BLUE)
    call cpct_setDrawCharM0_asm
    call print_tutorial
    ld ix, #tutorial_sprites
    call print_tutorial_sprites
    jr _loop_start_game
    
.include "cpctelera.h.s"
.include "game.h.s"
.include "interruptions.h.s"


man_interruptions_init::
    ;; espera hasta estar al inicio de la zona de VSYNC
    call cpct_waitVSYNC_asm
    halt
    halt
    call cpct_waitVSYNC_asm

    ld   de, #man_interruptions_handler_1
    call man_interruptions_set_handler
    ret

;; Input:
;;      DE = etiqueta a la función de interrupción
man_interruptions_set_handler::
    ;; cambiar la interrupción que haya por la nuestra
    ld  hl, #0x0038 ;; dirección que se ejecuta tras recibir interrupción
    ld  (hl), #0xC3 ;; JP
    inc hl
    ld  (hl), e
    inc hl
    ld  (hl), d
    inc hl
    ld  (hl), #0xC9 ;; ret
    ret


man_interruptions_handler_1::
    push af ;; necesario usar push y pop en lugar de exx y ex
    push bc ;; porque musicPlay se carga todos los registros
    push de
    push hl

    ;; executes music only if bit game_st_stop_music is 0
    ; call    man_game_check_stop_music
    ; jr      nz, _do_not_play_music
    call    cpct_akp_musicPlay_asm

;  _do_not_play_music:
    ld      de, #man_interruptions_handler_2
    call    man_interruptions_set_handler

    pop hl
    pop de
    pop bc
    pop af

    ei
    reti


man_interruptions_handler_2::
    ex af, af'
    exx

    ;; scan keyboard
    call    cpct_scanKeyboard_if_asm ;; interrupt-unsafe keyboard scan, only in controlled interruptions

    ld      de, #man_interruptions_handler_3
    call    man_interruptions_set_handler

    ex af, af'
    exx

    ei
    reti

    
man_interruptions_handler_3::
    push af
    push ix
    push iy
    exx

    ;; mute/unmute music
    ; ld      hl, #Key_M
    ; call    cpct_isKeyPressed_asm
    ; jr      z, _no_mute
    ; call    man_game_toggle_music

;  _no_mute:
    ld      de, #man_interruptions_handler_4
    call    man_interruptions_set_handler

    pop iy
    pop ix
    pop af
    exx

    ei
    reti


man_interruptions_handler_4::
    ex af, af'
    exx

    ld      de, #man_interruptions_handler_5
    call    man_interruptions_set_handler

    ex af, af'
    exx

    ei
    reti


man_interruptions_handler_5::
    ex af, af'
    exx

    ld      de, #man_interruptions_handler_6
    call    man_interruptions_set_handler

    ex af, af'
    exx

    ei
    reti


man_interruptions_handler_6::
    ex af, af'
    exx

    ld      de, #man_interruptions_handler_1
    call    man_interruptions_set_handler

    ex af, af'
    exx

    ei
    reti
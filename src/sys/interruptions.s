.include "cpctelera.h.s"
.include "interruptions.h.s"


sys_interruptions_init::
    ;; espera hasta estar al inicio de la zona de VSYNC
    call cpct_waitVSYNC_asm
    halt
    halt
    call cpct_waitVSYNC_asm

    ld   de, #sys_interruptions_handler_1
    call sys_interruptions_set_handler
    ret

;; Input:
;;      DE = etiqueta a la función de interrupción
sys_interruptions_set_handler::
    ;; cambiar la interrupción que haya por la nuestra
    ld  hl, #0x0038 ;; dirección que se ejecuta tras recibir interrupción
    ld  (hl), #0xC3 ;; JP
    inc hl
    ld  (hl), e
    inc hl
    ld  (hl), d
    ret


sys_interruptions_handler_1::
    push af ;; necesario usar push y pop en lugar de exx y ex
    push bc ;; porque musicPlay se carga todos los registros
    push de
    push hl

    ;; executes music and scans keyboard
    call    cpct_akp_musicPlay_asm
    call    cpct_scanKeyboard_if_asm

    ld      de, #sys_interruptions_handler_2
    call    sys_interruptions_set_handler

    pop hl
    pop de
    pop bc
    pop af

    ei
    reti


sys_interruptions_handler_2::
    ex af, af'
    exx

    ld      de, #sys_interruptions_handler_3
    call    sys_interruptions_set_handler

    ex af, af'
    exx

    ei
    reti

    
sys_interruptions_handler_3::
    ex af, af'
    exx

    ld      de, #sys_interruptions_handler_4
    call    sys_interruptions_set_handler

    ex af, af'
    exx

    ei
    reti


sys_interruptions_handler_4::
    ex af, af'
    exx

    ld      de, #sys_interruptions_handler_5
    call    sys_interruptions_set_handler

    ex af, af'
    exx

    ei
    reti


sys_interruptions_handler_5::
    ex af, af'
    exx

    ld      de, #sys_interruptions_handler_6
    call    sys_interruptions_set_handler

    ex af, af'
    exx

    ei
    reti


sys_interruptions_handler_6::
    ex af, af'
    exx

    ld      de, #sys_interruptions_handler_1
    call    sys_interruptions_set_handler

    ex af, af'
    exx

    ei
    reti
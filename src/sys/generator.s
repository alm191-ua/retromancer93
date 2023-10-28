.include "generator.h.s"
.include "man/entities.h.s"
.include "man/entity_templates.h.s"
.include "man/levels.h.s"
.include "man/game.h.s"
.include "cpctelera.h.s"

; tempo: 
;     .db 0x7F ; ritmo de generación de enemigos

;; Generates one enemy if there is space in the enemies array and
;;  there is space in screen
sys_generator_update:
    ;; check remaining enemies
    ld      a, (enemies_left)
    cp      #0
    ret     z

    call space_for_new_enemy    ;Comprobamos si hay hueco
    ;cp #0
    jr      c, espacio_para_enemigo
    ret

    ;CREAR ENEMIGO
    espacio_para_enemigo:       ;Si hay hueco se crea el enemigo
    ; ld a, (tempo)
    call    man_level_get_tempo ;; returns generation tempo in A
    ld      b, a
    call    random
    cp      #0
    jr      z, continuar_creando                  ;Salta si es igual a 0
    ret
    continuar_creando:




    ; call random_entre_3         ;Aleatorio del 0 al 2
    call man_level_get_rand_enemy ;; returns template in DE
    ld__ixh_d
    ld__ixl_e
    ; ld ix, #tmpl_enemy_void
    ; call multiplicar            ;Ponemos el tipo de enemigo aleatoriamente
    call man_enemy_create       ;Creas el enemigo
    
    ;; reducir los enemigos que quedan
    ld      a, (enemies_left)
    dec     a
    ld      (enemies_left), a


    ld__ixh_d   ;Quitar?
    ld__ixl_e

    ;CAMBIAR DE LINEA
    ld b, #0x01                 ;Bits que quieres el and del random
    call return_last_enemy
    call random                 ;Numero aleatorio
    jr z, linea_1       ;MIRAR SI ES 1 0 2
    ld    e_y (ix), #LANE2_Y
    ret
    linea_1:
    ld    e_y (ix), #LANE1_Y
    ret

    multiplicar:
        ld bc, #size_of_tmpl
        loop:
        cp #0
        jr z, end_loop
        dec a
        add ix, bc
        jr loop    ; Decrementa B y salta al bucle si no es 0
        end_loop:
        ret

    random_entre_3:
        call cpct_getRandom_xsp40_u8_asm
        and #0x03
        cp #3
        jr z, random_entre_3
        ret

    random:
        call cpct_getRandom_xsp40_u8_asm
        and a, b
        ;ld hl, #0xC000
        ;ld (hl), a
        ret

    
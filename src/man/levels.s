.include "levels.h.s"
.include "entity_templates.h.s"

.include "cpctelera.h.s"

level:
    .db 1 ;; level 1 by default

levels_tempo:
    .db level1_gen_tempo, level2_gen_tempo, level3_gen_tempo, level4_gen_tempo, level5_gen_tempo

levels_speed_rest:
    .db level1_speed_rest, level2_speed_rest, level3_speed_rest, level4_speed_rest, level5_speed_rest

levels_enemies:
    .dw lvl1_enemies, lvl2_enemies, lvl3_enemies, lvl4_enemies, lvl5_enemies

level_number_enemies:
    .db level1_num_enemies, level2_num_enemies, level3_num_enemies, level4_num_enemies, level5_num_enemies

;; la probabilidad de aparición de los enemigos 
;; va decrementando según su orden
;; 1: 50%
;; 2: 25%
;; 3: 12.5%
;; 4: ...
;; NOTA: el último enemigo tiene la misma probabilidad que el penúltimo
lvl1_enemies:
    .dw tmpl_enemy_o, enemies_end 
lvl2_enemies:
    .dw tmpl_enemy_o, tmpl_enemy_p, enemies_end
lvl3_enemies:
    .dw tmpl_enemy_o, tmpl_enemy_p, tmpl_enemy_void, tmpl_caldero, enemies_end
lvl4_enemies:
    .dw tmpl_enemy_void, tmpl_enemy_p, tmpl_enemy_o, tmpl_caldero, enemies_end
lvl5_enemies:
    .dw tmpl_enemy_o, tmpl_enemy_p, tmpl_enemy_void, enemies_end

unlocked_levels:
    .db 0x1F ;; only level one unlocked by default

;; changes level
;; Input:
;;      A = new level
man_level_set:
    ld      (level), a
    ret

;; Advances to next level
;; RETURN:
;;      A: 0 if there are more levels, 1 if the game is completed
man_level_next:
    ld      a, (level)
    inc     a

    cp      #6
    jr      z, _game_completed

    ld      (level), a
    ld      a, #0
    ret

 _game_completed:
    ld      a, #1
    ld      (level), a
    ret

;; Unlocks next level
;; 
man_level_unlock_next::

    ;; Check if the last level played was the last unlocked
    ld      a, (level)
    ld      b, a
    ld      a, (unlocked_levels)
 _repeat:
    rra
    djnz _repeat

    bit     0, a
    ret     nz

    ;; CHECKS IF THERE ARE STILL LEVELS TO UNLOCK
    ld     a, (unlocked_levels)
    ld     b, #0x1F
    cp     b

    ret    z

    sla    a                            ;; / Unlocks next level
    inc    a                            ;; | Moves the bits of unlocked_levels one to the left
    ld     (unlocked_levels), a         ;; | Adds 1, so that the level 1 is unlocked
                                        ;; \ Finally saves it
    
    ret

;; gets a value form the array depending on the level
;; Input:
;;      IX = start of array
;; Return:
;;      HL = value
_get_value:
    ld      a, (level)
 _value_loop:
    cp      #1
    jr      z, _value_end
    inc     ix
    dec     a
    jr      _value_loop
 
 _value_end:
    ld      a, (ix)
    ret


_get_value_2b:
    ld      a, (level)
 _value_loop2:
    cp      #1
    jr      z, _value_end2
    inc     ix
    inc     ix
    dec     a
    jr      _value_loop2
 
 _value_end2:
    ld      h, 0(ix)
    ld      l, 1(ix)
    ret

;; returns the tempo for the current level
;; Return:
;;      A = tempo
;; Preconditions:
;;      level must be between 1-5 (min-max levels)
man_level_get_tempo:
    push ix
    ld      ix, #levels_tempo
    call    _get_value
    pop ix
    ret

;; returns the number of enemies for the current level
;; Return:
;;      A = number of enemies
;; Preconditions:
;;      level must be between 1-5 (min-max levels)
man_get_number_enemies:
    push ix
    ld      ix, #level_number_enemies
    call    _get_value
    pop ix
    ret

;; returns the speed restriction for the current level
;; Return:
;;      A = speed restriction
;; Preconditions:
;;      level must be between 1-5 (min-max levels)
man_level_getSpeedRestriction:
    push ix
    ld      ix, #levels_speed_rest
    call    _get_value
    pop ix
    ret


;; gets random value from an array
;; Input:
;;      IX = start of array
;; Return:
;;      HL = choosen value
;; NOTE: starting values are more likely to be choosen
_get_rand:
    ld      h, 1(ix)
    ld      l, 0(ix)
    ld      a, l
    cp      #0
    jr      nz, _choose_rand
    ld      a, h
    cp      #0
    jr      nz, _choose_rand
    
    dec     ix
    dec     ix
    ld      h, 1(ix)
    ld      l, 0(ix)
    ret

 _choose_rand:
    call    cpct_getRandom_xsp40_u8_asm
    and     #0x01 ;; 1/2
    jr      nz, _next
    ld      h, 1(ix)
    ld      l, 0(ix)
    ret

 _next:
    inc     ix
    inc     ix
    jr      _get_rand

    ret

;; Return:
;;      DE = random enemy template for the current level
;; Preconditions:
;;      level must be between 1-5 (min-max levels)
man_level_get_rand_enemy:
    push ix
    ld      ix, #levels_enemies
    call    _get_value_2b

    ex de, hl
    ld__ixh_e
    ld__ixl_d
    call    _get_rand
    ex      de, hl

    pop ix

    ret
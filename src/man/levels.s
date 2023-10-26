.include "levels.h.s"

.include "cpctelera.h.s"

level:
    .db 1 ;; level 1 by default

levels_tempo:
    .db level1_gen_tempo, level2_gen_tempo, level3_gen_tempo, level4_gen_tempo, level5_gen_tempo

levels_speed_rest:
    .db level1_speed_rest, level2_speed_rest, level3_speed_rest, level4_speed_rest, level5_speed_rest

unlocked_levels:
    .db 0x01 ;; only level one unlocked by default

;; changes level
;; Input:
;;      A = new level
man_level_set:
    ld      (level), a
    ret


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
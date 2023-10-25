.include "levels.h.s"

.include "cpctelera.h.s"

level:
    .db 1 ;; level 1 by default

levels_tempo:
    .db level1_gen_tempo, level2_gen_tempo, level3_gen_tempo, level4_gen_tempo, level5_gen_tempo

unlocked_levels:
    .db 0x01 ;; only level one unlocked by default

;; changes level
;; Input:
;;      A = new level
man_level_set:
    ld      (level), a
    ret

;; returns the tempo for the current level
;; Return:
;;      A = tempo
;; Preconditions:
;;      level must be between 1-5 (min-max levels)
man_level_get_tempo:
    ld      a, (level)
    ld      ix, #levels_tempo
 _tempo_loop:
    cp      #1
    jr      z, _tempo_end
    inc     ix
    dec     a
    jr      _tempo_loop
 
 _tempo_end:
    ld      a, (ix)
    ret

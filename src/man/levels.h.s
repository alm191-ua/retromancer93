
;; enemies generation tempo 
level1_gen_tempo = 0x7F ; 0b 0111.1111
level2_gen_tempo = 0x3F ; 0b 0011.1111
level3_gen_tempo = 0x1F ; 0b 0001.1111
level4_gen_tempo = 0x0F ; 0b 0000.1111
level5_gen_tempo = 0x07 ; 0b 0000.0111

max_level = 5

.globl level

.globl man_level_set
.globl man_level_get_tempo
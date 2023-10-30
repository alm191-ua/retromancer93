.globl cpct_getRandom_xsp40_u8_asm


;; enemies generation tempo 
level1_gen_tempo = 0x7F ; 0b 0111.1111
level2_gen_tempo = 0x3F ; 0b 0011.1111
level3_gen_tempo = 0x1F ; 0b 0001.1111
level4_gen_tempo = 0x0F ; 0b 0000.1111
level5_gen_tempo = 0x07 ; 0b 0000.0111

;; speed restriction
level1_speed_rest   = 0x03 ; medium restriction
level2_speed_rest   = 0x03 ; medium restriction
level3_speed_rest   = 0x01 ; small  restriction
level4_speed_rest   = 0x01 ; small  restriction
level5_speed_rest   = 0x01 ; small  restriction

;; number of enemies per level
level1_num_enemies  = 5
level2_num_enemies  = 20
level3_num_enemies  = 50
level4_num_enemies  = 100
level5_num_enemies  = 120

max_level = 5
enemies_end = 0x0000

;; unlocked levels positions
level_1 = 0x01
level_2 = 0x02
level_3 = 0x04
level_4 = 0x08
level_5 = 0x10


.globl level
.globl unlocked_levels

.globl man_level_set
.globl man_level_get_tempo
.globl man_level_getSpeedRestriction
.globl man_get_number_enemies
.globl man_level_get_rand_enemy
.globl man_level_unlock_next

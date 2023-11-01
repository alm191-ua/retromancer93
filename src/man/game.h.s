.globl frame_counter
.globl enemies_left
.globl man_game_init
.globl man_game_play
.globl man_game_start
.globl man_game_pause
.globl man_game_check_stop_music
.globl man_game_toggle_music
.globl man_game_check_finished
.globl man_game_check_victory

.globl man_game_inc_frames_counter
.globl man_game_inc_points
.globl man_game_dec_points

.globl cpct_setDrawCharM0_asm
.globl cpct_drawStringM0_asm
.globl cpct_drawSprite_asm

.globl cpct_akp_musicInit_asm
.globl _song_play

number_of_enemies = 50

;; game states
game_st_finish      = 1
game_st_pause       = 2
game_st_win         = 4
game_st_stop_music  = 8
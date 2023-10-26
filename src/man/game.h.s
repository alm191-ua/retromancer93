.globl frame_counter
.globl sys_game_init
.globl sys_game_play
.globl sys_game_start
.globl sys_game_pause
.globl sys_game_check_finished

.globl sys_game_inc_frames_counter
.globl sys_game_inc_points
.globl sys_game_dec_points

.globl cpct_setDrawCharM0_asm
.globl cpct_drawStringM0_asm
.globl cpct_drawSprite_asm



;; game states
game_st_finish  = 1
game_st_pause   = 2
.include "input.h.s"
.include "man/entities.h.s"
.include "man/game.h.s"
.include "animations.h.s"
.include "render.h.s"
.include "cpctelera.h.s"


;; do something to the entity if is marked as e_cmp_input
;; Input:
;;  NO INPUT NEEDED, ONLY WORKS WITH THE PLAYER
sys_input_player_update:
    ; ;; check input component
    ; ld      a, e_comp (ix)
    ; and     #e_cmp_input
    ; ret     z

    ; get player
    ld      ix, #player

    ; call    cpct_scanKeyboard_asm ; ya se hace en las interrupciones
    call    cpct_isAnyKeyPressed_asm
    ret     z
    
    ;; check O
    ld      hl, #Key_O
    call    cpct_isKeyPressed_asm
    jr      nz, _O_pressed
    ;; check P
    ld      hl, #Key_P
    call    cpct_isKeyPressed_asm
    jr      nz, _P_pressed
    ;; check Q
    ld      hl, #Key_Q
    call    cpct_isKeyPressed_asm
    jr      nz, _Q_pressed
    ;; check A
    ld      hl, #Key_A
    call    cpct_isKeyPressed_asm
    jp      nz, _A_pressed ;;way to _A_pressed too long, can't do relative jump

    ; ;; check K
    ; ld      hl, #Key_K
    ; call    cpct_isKeyPressed_asm
    ; call    nz, man_enemy_kill_all

    ret  ;; other key pressed

_O_pressed:
    ; 1 -> attack animation
    ; 2 -> check first enemy's position
    ; 3 -> kill enemy. let enemy move until arrives to player
    ; 4 -> increase points

    ;;-------- attack animation
    ld      ix, #player_attack
    ld      e_anim_counter(ix), #0
    ld      hl, #player_attack_o
    ld      e_anim   (ix), l
    ld      e_anim+1 (ix), h

    ;;-------- check enemy lane
    ld      ix, (first_enemy)
    ld      a, e_y (ix)
    ld      hl, #target_player_position
    ld      b, (hl)
    cp      b
    ret     nz ;; if enemy position is different to player position

    ;;-------- check enemy type
    ld      hl, #killable_with_o
    ld      a, e_type (ix)
    call    is_in_list ;; A in HL list
    or      a
    ret     z ;; if is not on list, do not kill

    ; cp      #type_enemy_void
    ; jr      z, _kill_enemy
    ; cp      #type_caldero
    ; jr      z, _kill_enemy
    ; cp      #type_enemy_o
    ; ret     nz

 _kill_enemy:
    ld      a, e_x (ix)
    sub     #KILLING_ENEMIES_POS
    ret     nc ;; si no ha llegado a la posicion no muere

    jp      man_enemy_kill


_P_pressed:
    ;;-------- attack animation
    ld      ix, #player_attack
    ld      e_anim_counter(ix), #0
    ld      hl, #player_attack_p
    ld      e_anim   (ix), l
    ld      e_anim+1 (ix), h

    ;;-------- check enemy lane
    ld      ix, (first_enemy)
    ld      a, e_y (ix)
    ld      hl, #target_player_position
    ld      b, (hl)
    cp      b
    ret     nz ;; if enemy position is different to player position

    ;;-------- check enemy type
    ld      hl, #killable_with_p
    ld      a, e_type (ix)
    call    is_in_list ;; A in HL list
    or      a
    ret     z ;; if is not on list, do not kill
    jr      _kill_enemy


_Q_pressed:
    ;; check lane of the player
    ld  a, e_y (ix)
    cp  #LANE1_Y_PLAYER
    ret z

    ;; move to the bottom lane
    ld e_anim_counter(ix), #0
    ld hl, #player_tp_anim
    ld e_anim   (ix), l
    ld e_anim+1 (ix), h
    ld hl, #target_player_position
    ld (hl), #LANE1_Y_PLAYER
    ret
_A_pressed:
    ;; check lane of the player
    ld  a, e_y (ix)
    cp  #LANE2_Y_PLAYER
    ret z

    ;; move to the bottom lane
    ld e_anim_counter(ix), #0
    ld hl, #player_tp_anim
    ld e_anim   (ix), l
    ld e_anim+1 (ix), h
    ld hl, #target_player_position
    ld (hl), #LANE2_Y_PLAYER
    ret
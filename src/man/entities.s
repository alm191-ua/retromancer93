.include "cpctelera.h.s"
.include "entities.h.s"
.include "entity_templates.h.s"
.include "sys/animations.h.s"
.include "man/game.h.s"


entities::
    player:         .ds size_of_tmpl 
    player_attack:  .ds size_of_tmpl
    enemies_array:  .ds size_of_array 

    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    .db #0xBE, #0xEF
    
next_free_enemy: .dw enemies_array
first_enemy: .dw enemies_array
last_enemy: .dw enemies_array


killable_with_o:
    .db type_enemy_o, type_enemy_void, type_caldero, 0
killable_with_p:
    .db type_enemy_p, type_enemy_void, type_caldero, 0

man_entity_init:
    ld hl, #enemies_array
    ld (next_free_enemy), hl
    ld (first_enemy), hl
    ld (hl), #0

    ld  d, h                   ;; / DE = HL + 1
    ld  e, l                   
    inc de  

    ld bc, #size_of_array-1
    ldir
    ret

;; creates player and player attack
man_player_create:
    ld      hl, #player
    ex      de, hl 
    ld      hl, #tmpl_player ;; load entity template in HL
    ld      bc, #size_of_tmpl
    ldir

    ld      hl, #player_attack
    ex      de, hl 
    ld      hl, #tmpl_player_attack ;; load entity template in HL
    ld      bc, #size_of_tmpl
    ldir
    ret


;;INPUT:
;;   IX: Entities' template
;;Returns:
;;   DE = new entity
man_enemy_create:

    ld      hl, (next_free_enemy)
    ld      a, (hl)
    cp      #0xBE ;; end of entities array
    jr      z, _move_pointer_to_first
    
    cp      #type_invalid
    jr      z, _create
    ret
    
    _move_pointer_to_first: 
        ld  hl, #enemies_array
        ld  (next_free_enemy),hl
        jr  man_enemy_create

    _create:
        ld__d_ixh
        ld__e_ixl
        ld      hl, (next_free_enemy)
        ld      (last_enemy), hl
        ex      de, hl ;; load entity template in HL
        push    de  ;;  Saves the pointer to the new entity
        ld      bc, #size_of_tmpl
        ldir

        ld  (next_free_enemy), de
        pop     de

    ret
    

;; Input:
;;      IX = entity to be marked
man_enemy_set4destruction:
    ld      a, e_comp (ix)
    or      #e_cmp_dead
    ld      e_comp (ix), a
    ret

;; prepares an enemy for death, allows him to solve his unfinished business (animation)
;; Input:
;;      IX = enemy to be prepared
man_enemy_set4dead:
    ld      a, e_comp (ix)
    or      #e_cmp_set4dead
    ld      e_comp (ix), a

    ld      e_anim_counter(ix), #-1
    ld      h, e_death_anim+1 (ix)
    ld      l, e_death_anim   (ix)
    ld      e_anim(ix), l
    ld      e_anim+1(ix), h
    ret

;; igual que la anterior pero la animación es la genérica
;; Input:
;;      IX = enemy to be prepared
man_enemy_set4dead_generic:
    ld      a, e_comp (ix)
    or      #e_cmp_set4dead
    ld      e_comp (ix), a

    ld      e_anim_counter(ix), #0
    ; ld      hl, #enemy_death_anim
    ld      h, #<enemy_death_anim
    ld      l, #>enemy_death_anim
    ld      e_anim(ix), h
    ld      e_anim+1(ix), l
    ret


;; kill one enemy. +1 points
;; Input:
;,      IX = eenemy to be killed
man_enemy_kill:
    ;; check death state
    ld      a, e_comp (ix)
    and     #e_cmp_set4dead
    ret     nz
    
    call    man_enemy_set4dead

    ld      bc, #default_enemies_points_value
    call    sys_game_inc_points
    ret

;; kill all the enemies
man_enemy_kill_all:
    ld      hl, #man_enemy_kill
    call    man_enemy_forall
    ret

;; Input:
;;      IX = entity to be destroyed
man_enemy_destroy:
    ; check dead bit
    ld      a, e_comp (ix)
    and     #e_cmp_dead
    ret     z

    ;; destroy entity
    ld      e_type(ix), #type_invalid

    ld      hl, (first_enemy)
    ld      a, l
    add     #size_of_tmpl  ; size_of_tmpl = 16
    jr      nc, _check_loop_first_enemy
    inc     h

 _check_loop_first_enemy:
    ld      l, a

    ld      a, (hl)
    cp      #0xBE
    jr      nz, _destroy_enemy_end

    ld      hl, #enemies_array
    jr      _destroy_enemy_end

 _destroy_enemy_end:
    ld      (first_enemy), hl
    ret



;; Recorre únicamente los enemigos
;; Input:
;;      HL = function to call for all enemies
man_enemy_forall:
    ld      (_func), hl
    ld      ix, #enemies_array
    jr      _forall_loop

;; Recorre tanto el jugador como los enemigos
;; Input:
;;      HL = function to call for player and all enemies
man_entity_forall:
    ld      (_func), hl
    ld      ix, #player

_forall_loop:
    ;; check final of enemies array
    ld      a, (ix)
    cp      #0xBE
    ret     z

    ;; check invalid entity
    ld      a, e_type (ix)
    cp      #type_invalid
    jr      z, _continue
_func = .+1
    call    (_func)


_continue:
    ld      bc, #size_of_tmpl
    add     ix, bc
    jr      _forall_loop
    
    ret


;; Return:
;;      A = number of enemies in screen
man_enemies_curr_num:
    ld      d, #0
    ld      ix, #enemies_array
 _curr_en_loop:
    ld      a, e_type(ix)
    cp      #0xBE ;; end of array
    jr      z, _end_curr_en
    cp      #0 ;; invalid enemy
    jr      z, _next_curr_en
    inc     d
 _next_curr_en:
    ld      bc, #size_of_tmpl
    add     ix, bc
    jr      _curr_en_loop
 _end_curr_en:
    ld      a, d
    ret

;; Input:
;;      A = byte to compare
;;      HL = list to search
;; Return:
;;      A = same byte if is in list, 0 if not
is_in_list:
    push ix
    ; ld      ix, hl
    ex de, hl
    ld__ixh_d
    ld__ixl_e
    ld      b, a
 _list_loop:
    ld      a, (ix)
    cp      #0
    jr      z, _end_list ;; not found
    cp      b
    jr      z, _end_list ;; byte found in list

    inc     ix
    jr      _list_loop

 _end_list:
    pop ix
    ret

space_for_new_enemy:
    ld ix, (last_enemy)
    ld      a, e_type (ix)
    cp      #0 ;; invalid enemy
    jr      z, _space_available
    ld      a, e_x(ix) ;es ix
    ;a<61?
    sub     a, #61
    jr      c, _space_available

 _no_space_available:
    or      a
    ret
 _space_available:
    scf
    ret

return_last_enemy:
    ld ix, (last_enemy)
    ret
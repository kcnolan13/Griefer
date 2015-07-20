///framely_player_controls()

//bail out if in text entry somewhere
if chat_feed.entry.input_active
    return false

//BUTTON HOLDS
if pressing_left()
    hold_a()

if pressing_right()
    hold_d()
    
//BUTTON PRESSES
if input_check_pressed(mapped_control(C_EVADE))
    press_shift()
    
if input_check_pressed(mapped_control(C_SIDEARM_QUICK))
    quickselect_sidearm()

if input_check_pressed(mapped_control(C_PRIMARY))
    select_primary()
    
if input_check_pressed(mapped_control(C_SECONDARY))
    select_secondary()
    
if input_check_pressed(mapped_control(C_SIDEARM))
    select_sidearm()
    
if input_check_pressed(mapped_control(C_GRENADES))
    select_grenades()
    
if input_check_pressed(mapped_control(C_NEXT))
    press_q()
    
if input_check_pressed(mapped_control(C_PREV))
    press_e()
    
if input_check_pressed(mapped_control(C_CROUCH))
    press_s()
    
if input_check_pressed(mapped_control(C_JUMP))
    press_w()
    
if input_check_pressed(mapped_control(C_DROP))
    press_x()
    
//BUTTON RELEASES
if input_check_released(mapped_control(C_MOVE_LEFT))
    release_a()
    
if input_check_released(mapped_control(C_MOVE_RIGHT))
    release_d()
    
if input_check_released(mapped_control(C_JUMP))
    release_w()

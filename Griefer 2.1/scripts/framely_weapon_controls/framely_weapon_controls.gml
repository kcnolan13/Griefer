/// @description framely_player_controls()
/// @function framely_player_controls

//bail out if in text entry somewhere
if chat_feed.entry.input_active
    return false

//BUTTON HOLDS
if input_check(mapped_control(C_SHOOT))
{
    mi_jugador = find_player(varRead("my_player"))
    if not (mi_jugador < 0 or is_bot(mi_jugador))
        weapon_hold_left()
}

    
//BUTTON PRESSES
if input_check_pressed(mapped_control(C_SHOOT))
{
    mi_jugador = find_player(varRead("my_player"))
    if not (mi_jugador < 0 or is_bot(mi_jugador))
        weapon_press_left()
}

if input_check_pressed(mapped_control(C_QUICKTOSS))
{
    if varRead("active") and not varRead("quicktoss_timer")
    {
        mi_jugador = find_player(varRead("my_player"))
        if not (mi_jugador < 0 or is_bot(mi_jugador))
        {
            if objVarRead(mi_jugador,"controllable")
            {
                weapon_press_right()
            }
        }
    }
}

if input_check_pressed(mapped_control(C_PICKUP))
{
    exclude_bots = true
    weapon_press_space()
}

if input_check_pressed(mapped_control(C_RELOAD))
{
    mi_jugador = find_player(varRead("my_player"))
    if mi_jugador = net_manager.local_player
        weapon_press_r() 
}

//BUTTON RELEASES
if input_check_released(mapped_control(C_SHOOT))
{
    mi_jugador = find_player(varRead("my_player"))
    if not (mi_jugador < 0 or is_bot(mi_jugador))
        weapon_release_left()
}

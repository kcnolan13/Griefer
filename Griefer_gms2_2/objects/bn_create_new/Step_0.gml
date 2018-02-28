if global.using_gamepad 
{
    if gamepad_button_check_pressed(global.devno,global.cvals[C_JUMP]) 
    or gamepad_button_check_pressed(global.devno,global.cvals[C_SHOOT])
    {
        event_perform(ev_mouse,ev_global_left_press)
    }
    
    if gamepad_button_check(global.devno,global.cvals[C_JUMP]) 
    or gamepad_button_check(global.devno,global.cvals[C_SHOOT])
    {
        event_perform(ev_mouse,ev_global_left_button)
    }
}

action_inherited();

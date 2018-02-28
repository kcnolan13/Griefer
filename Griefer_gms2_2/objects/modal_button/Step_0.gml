/// @description inherit stuff
event_inherited()

if is_page and instance_exists(modal_table)
{
    if page_flag > modal_table.page_max //and popped_in
    {
        //birth_delay = 5
        alpha = 0.25
        scale = 0.85
    }
    
    if page_flag = modal_table.force_page
    {
        active = true
        highlightable = false
    }
    else
    {
        active = false
        highlightable = true
    }
}   

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

if keyboard_check(vk_enter) and can_press_enter and popped_in and (not pressed_enter or can_press_enter_always)
{
    cursor.x = x
    cursor.y = y
    event_perform(ev_mouse,ev_global_left_press)
    pressed_enter = true
}

if clicked
    clicked --


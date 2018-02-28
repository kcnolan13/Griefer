/// @description stuff
if alpha < 0.1
{
    input_active = false
    str_cursor = ""
}

//detect when two input fields are active at same time
if room = rm_login and input_active
{
    /*if bn_login_user.field_password.input_active and id != bn_login_user.field_password.id
    {
        input_active = false
        str_cursor = ""
    }*/
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

if not input_active exit

if tab_delay > 0
tab_delay --

if input_active
{
    input_string = string_replace_all(input_string,"#","")
    
    if keyboard_check(vk_backspace)
    {
        backspace_counter++
    }
    else
    {
        backspace_counter = 0
        backspace_delay = backspace_hold_delay
    }
    
    if keyboard_check_pressed(vk_backspace) or backspace_counter > backspace_hold_delay
    {
        if backspace_counter > backspace_delay
        {
            if string_length(keyboard_string) > 0
            {
                keyboard_string = string_copy(keyboard_string,1,string_length(keyboard_string)-1)
                input_string = keyboard_string
            }
            backspace_delay = 10
            backspace_counter = 0
        }
    }
    
    if keyboard_check_pressed(vk_tab) and not tab_delay and room = rm_login
    {
        tab_delay = 5
        input_active = false
        str_cursor = ""
        with input_field
        {
            if id != other.id
            {
                tab_delay = 5
                input_active = true
                keyboard_string = ""
                input_string = ""
                str_cursor = "|"
            }
        }
    }
}

/* */
/*  */

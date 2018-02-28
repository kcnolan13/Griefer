/// @description all dat ish
event_inherited()

if auto_capitalize or is_username
{
    text = capwords(text)
}

if active
{
    text = string_replace_all(text,"#","")
    //PRESS BACKSPACE
    if keyboard_check_pressed(vk_backspace)
    {
        if not backspace_counter    
        {
            if string_length(text) > 0
            {
                audio(snd_keystroke,GAIN_KEYSTROKE)
                text = string_copy(text,1,string_length(text)-1)
                keyboard_string = text
            }
        }
        backspace_counter ++
        if backspace_counter > backspace_delay
            backspace_counter = 0
    }
    else backspace_counter --//sub_real(backspace_counter,1)
    
    //PRESS TAB
    if keyboard_check_pressed(vk_tab)
    {
        if not tab_counter
        {
            largest_sequence = sequence
            with bn_input_field
            {
                if sequence > other.largest_sequence
                    other.largest_sequence = sequence
            }
            with bn_input_field
            {
                if sequence = other.sequence+1 or sequence = 1 and other.sequence = other.largest_sequence
                {
                    tab_counter = 1
                    cursor.x = x
                    cursor.y = y
                    //click into the next modal
                    event_perform(ev_mouse,ev_global_left_press)
                }
            }
            
            //click away from this modal
            event_perform(ev_mouse,ev_global_left_press)
        }
        
        tab_counter += real_speed(1)
        if tab_counter > tab_delay
            tab_counter = 0
    }
    else tab_counter = 0
}

if active
{
    can_randomize = false
    text_color = text_color_input
}
else
{
    text_color = text_color_default
    if text = ""
    {
        text = text_default
        auto_clear = true
    }
}

//randomize username
random_counter ++
if is_username and randomize_username and can_randomize and random_counter > random_delay and (have_randomized or random_counter > random_nth_frame)
{
    have_randomized = true
    do_random = true
    with bn_input_field
    {
        if active
            other.do_random = false
    }
    if do_random
    {
        text = generate_name(0.01)
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

str_cursor_counter ++
if str_cursor_counter > str_cursor_delay
    str_cursor_counter = 0
    
if not str_cursor_counter
{
    if str_cursor = "|"
        str_cursor = ""
    else
        str_cursor = "|"
}

if clicked
    clicked --


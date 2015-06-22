///capture input

//KEYBOARD
if keyboard_check(vk_anykey)
{
    map_control(label_name,keyboard_key)
    return true
}

//MOUSE
if mouse_check_button(mb_any)
{
    map_control(label_name,mouse_button)
    return true
}

//GAMEPAD AXES
for (var i=0; i<4; i++)
{
    if gamepad_axis_check(global.devno,input_manager.axes[i])
    {
        map_control(label_name,input_manager.axes[i])
        return true
    }   
}

//GAMEPAD BUTTONS
gp_buttons[0] = gp_face1
gp_buttons[1] = gp_face2
gp_buttons[2] = gp_face3
gp_buttons[3] = gp_face4
gp_buttons[4] = gp_shoulderl
gp_buttons[5] = gp_shoulderr
gp_buttons[6] = gp_shoulderrb
gp_buttons[7] = gp_shoulderlb
gp_buttons[8] = gp_select
gp_buttons[9] = gp_start
gp_buttons[10] = gp_stickl
gp_buttons[11] = gp_stickr
gp_buttons[12] = gp_padu
gp_buttons[13] = gp_padd
gp_buttons[14] = gp_padl
gp_buttons[15] = gp_padr

for (var i=0; i < getLength(gp_buttons); i++)
{
    if gamepad_button_check(global.devno, gp_buttons[i])
    {
        map_control(label_name,gp_buttons[i])
        return true
    }
}
/// @description click_pressed
if global.using_gamepad
{
    if gamepad_button_check_pressed(global.devno,global.cvals[C_CROUCH]) 
    or gamepad_button_check_pressed(global.devno,global.cvals[C_PICKUP])
        return true
}
else if mouse_check_button_pressed(mb_right)
    return true
    
    
return false
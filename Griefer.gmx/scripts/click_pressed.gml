///click_pressed
if global.using_gamepad
{
    if gamepad_button_check_pressed(global.devno,global.cvals[C_JUMP]) 
    or gamepad_button_check_pressed(global.devno,global.cvals[C_SHOOT])
        return true
}
else if mouse_check_button_pressed(mb_left)
    return true
    
    
return false
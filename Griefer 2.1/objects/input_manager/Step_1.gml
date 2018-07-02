/// @description gamepad cursor control
if global.using_gamepad
{
    if in_match()
    {
        //printf("::: global.cursor_dir = "+string(global.cursor_dir))
        //printf("::: cursor @ "+string(cursor.x)+", "+string(cursor.y))
    } else
    {
        if gamepad_axis_check(global.devno,gp_axisrh) or gamepad_axis_check(global.devno,gp_axisrv)
        {
            cursor.x += global.cvals[C_MOUSE_SENS]*gamepad_stick_val(gp_axisrh)
            cursor.y += global.cvals[C_MOUSE_SENS]*gamepad_stick_val(gp_axisrv)
        }
        else if gamepad_axis_check(global.devno,gp_axislh) or gamepad_axis_check(global.devno,gp_axislv)
        {
            cursor.x += global.cvals[C_MOUSE_SENS]*gamepad_stick_val(gp_axislh)
            cursor.y += global.cvals[C_MOUSE_SENS]*gamepad_stick_val(gp_axislv)
        }
        
        //keep cursor within bounds
        if cursor.x > room_width    cursor.x = room_width
        if cursor.x < 0             cursor.x = 0
        if cursor.y > room_height   cursor.y = room_height
        if cursor.y < 0             cursor.y = 0
            
    }
}



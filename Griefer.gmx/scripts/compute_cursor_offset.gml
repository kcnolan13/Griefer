///compute_cursor_offset()

if not is_bot(id)
{
    
    if not global.using_gamepad //or  global.using_gamepad 
    {
        cursor.x = mouse_x
        cursor.y = mouse_y
    }
    else
    {
        if not computed_curs and (gamepad_axis_check(global.devno,gp_axisrh) or gamepad_axis_check(global.devno,gp_axisrv))
        {
            computed_curs = true
            
            if varRead("alive")
            {
                var ang_lerp = 1
                
                var addx = floor(global.cvals[C_LOOK_SENS]*gamepad_stick_val(gp_axisrh))
                var addy = floor(global.cvals[C_LOOK_SENS]*gamepad_stick_val(gp_axisrv))
                var ang = point_direction(x,y,cursor.x+addx,cursor.y+addy)
                
                if point_distance(x,y,cursor.x+addx,cursor.y+addy) < (global.cursor_offset)
                {
                    curs_xoff = floor(curs_xoff+addx)
                    curs_yoff = floor(curs_yoff+addy)
                }
                else
                {
                    var new_ang = lerp(global.cursor_dir,ang,ang_lerp)
                    curs_xoff = floor(trigx(global.cursor_offset,new_ang))
                    curs_yoff = floor(trigy(global.cursor_offset,new_ang))
                }
            }
            global.cursor_dir = floor(point_direction(x,y,cursor.x,cursor.y))
        }
        
        cursor.x = x+curs_xoff//mouse_x+256
        cursor.y = y+curs_yoff//mouse_y+256
    }
}
/// @description draw the glare surface on the screen and also  FLASHBANGS
time_of_day += time_incr

if time_of_day > 1
time_of_day = 0

//glr_set_ambient_daytime(time_of_day)

//if in_match()
//    glr_draw(view_xview,view_yview);

    
if in_match() and instance_exists(net_manager.local_player) and objVarRead(net_manager.local_player,"flash_hp") < 100
{
    draw_set_color(c_white)
	draw_enable_alphablend(true)
    draw_set_alpha((100-objVarRead(net_manager.local_player,"flash_hp"))/100+0.1)
    draw_rectangle(__view_get( e__VW.XView, 0 )-64*3,__view_get( e__VW.YView, 0 )-64*3,__view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )+64*3,__view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )+64*3,false)
}


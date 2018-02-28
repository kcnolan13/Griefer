/// @description draw id and coords

if net_manager.snapshot_mode exit

if in_match() 
{
    do_draw = true
    
    with cursor_generic
    {
        if active and counter > 2 and not match_starting() and not match_ending() and not global.map_editor and not instance_exists(modal_controls)
            other.do_draw = false
    }
    
    if not do_draw
        return false
}

var spr = icon_cursor_small
var xscale = cursor_width/sprite_get_width(spr)
var yscale = xscale

draw_sprite_ext(spr,image_index,(x-__view_get( e__VW.XView, 0 ))*WVIEW/__view_get( e__VW.WView, 0 ),(y-__view_get( e__VW.YView, 0 ))*HVIEW/__view_get( e__VW.HView, 0 ),xscale,yscale,image_angle,image_blend,image_alpha)
draw_set_color(c_white)

/*
draw_set_alpha(0.35)
draw_flash_compensate()

var pts = points*2
var ptsize = point_size*0.5
for (var i=0; i<pts; i++)
{
    var ang = (rot-90)+i/pts*360
    var rad = point_rad*1.5*lerp(global.notification_scale,1,0.75)
    var drawx = x+trigx(rad,ang)
    var drawy = y+trigy(rad,ang)
    draw_circle(drawx,drawy,ptsize,false)
}*/

/*
draw_set_alpha(1)
draw_flash_compensate()
for (var i=0; i<points; i++)
{
    var ang = rot+i/points*360
    var rad = point_rad*lerp(global.notification_scale,1,0.75)
    var drawx = x+trigx(rad,ang)
    var drawy = y+trigy(rad,ang)
    draw_circle(drawx,drawy,point_size,false)
}

draw_set_alpha(1)
draw_circle(x,y,point_size/2,false)*/




/* */
/*  */

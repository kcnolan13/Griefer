/// @description draw notifications
event_inherited()

var num_new = num_new_bparts()

if num_new
{
    draw_notification(num_new,left+width*scale-global.noffset*scale,top+global.noffset*scale,scale*notif_scale,make_colour_hsv(hue,255,180),1)
}


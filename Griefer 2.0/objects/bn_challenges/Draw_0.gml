/// @description draw notifications
event_inherited()

var num_new = num_new_challenges()

if num_new and popped_in
{
    draw_notification(num_new,left+width*scale-global.noffset*scale,top+global.noffset*scale,scale*notif_scale,make_colour_hsv(hue,255,180),1)
}


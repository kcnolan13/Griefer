/// @description snap to snap_obj and find deadguy
event_inherited()

if notif_time
    notif_time --

if fade_out
{
    printf(":::feed_message fading out: "+string(alpha))    
}

if not instance_exists(deadguy) and avname2 != ""
{
    var test = find_pname_avatar(avname2)
    if instance_exists(test)
    {
        deadguy = test
        deadguy_blood_color = objVarRead(deadguy,"blood_color")
    }
}

lerp_real_ycurrent = lerp_real(lerp_real_ycurrent,lerp_real_ytarget,lerp_real_ystep)

if instance_exists(snap_obj)
{
    x = snap_obj.x
    y = snap_obj.y-snap_obj.master_scale*(snap_obj.height/2-lerp_real_ycurrent)
    master_scale = snap_obj.master_scale
}

label = text


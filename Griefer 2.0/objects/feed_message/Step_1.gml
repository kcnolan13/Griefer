/// @description snap to snap obj
if instance_exists(snap_obj)
{
    x = snap_obj.x
    y = snap_obj.y-snap_obj.master_scale*(snap_obj.height/2-lerp_real_ycurrent)
    master_scale = snap_obj.master_scale
}


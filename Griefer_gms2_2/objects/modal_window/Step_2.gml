/// @description snap
if not is_gui
{
    if snapped and snap_by_percent
    {
        x = __view_get( e__VW.XView, 0 )+view_xpercent*__view_get( e__VW.WView, 0 )
        y = __view_get( e__VW.YView, 0 )+view_ypercent*__view_get( e__VW.HView, 0 )
        if bind_to_global_xoff
            x += global.xoff
    }
    else if snapped
    {
        x = __view_get( e__VW.XView, 0 )+view_xoff
        y = __view_get( e__VW.YView, 0 )+view_yoff
        if bind_to_global_xoff
            x += global.xoff
    }   
}


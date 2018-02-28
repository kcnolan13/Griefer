/// @description modal_recalculate_snap()
/// @function modal_recalculate_snap
if snap_2view = true and counter > 1 and not is_gui and x > 0 and y > 0
{
    snapped = true
    view_xoff = x - __view_get( e__VW.XView, 0 )
    view_yoff = y - __view_get( e__VW.YView, 0 )
    view_xpercent = abs(view_xoff/__view_get( e__VW.WView, 0 ))
    view_ypercent = abs(view_yoff/__view_get( e__VW.HView, 0 ))
}

///modal_recalculate_snap()
if snap_2view = true and counter > 1 and not is_gui and x > 0 and y > 0
{
    snapped = true
    view_xoff = x - view_xview
    view_yoff = y - view_yview
    view_xpercent = abs(view_xoff/view_wview)
    view_ypercent = abs(view_yoff/view_hview)
}
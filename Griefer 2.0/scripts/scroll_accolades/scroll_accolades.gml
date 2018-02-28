//PERFORM SCROLLING

if chevron_left
{
var do_scroll = false
with accolade_generic
{
    if xtarget < accolade_manager.accolade_xmin-width/2
        do_scroll = true
}
//scroll left
if do_scroll
with accolade_generic
{
    xtarget += accolade_manager.sspeed*(width+accolade_manager.grid_hsep)
    left += accolade_manager.sspeed*(width+accolade_manager.grid_hsep)
}
}
else if chevron_right
{
    var do_scroll = false
    with accolade_generic
    {
        if xtarget > accolade_manager.accolade_xmax+width/2
            do_scroll = true
    }
    if do_scroll
        //scroll right
        with accolade_generic
        {
            xtarget -= accolade_manager.sspeed*(width+accolade_manager.grid_hsep)
            left -= accolade_manager.sspeed*(width+accolade_manager.grid_hsep)
        }
}

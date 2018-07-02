/// @description all dat ish
if not modal_highlighted(id)
{
    exit_child = true
    exit
}

if clicked exit
    clicked = 2

if instance_exists(modal_controls)
{
    modal_controls.mode_index = 2
    with bn_cedit fade_out = true
    with bn_clabel fade_out = true
    with bn_match_quit fade_out = true
    with modal_controls
    {
        regen_cedits(FL_NORMAL)
    }
}


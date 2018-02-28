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
    with bn_cedit fade_out = true
    with bn_clabel fade_out = true
    with bn_match_quit fade_out = true
    with bn_restore_defaults fade_out = true
    with bn_use_keyboard fade_out = true
    with bn_use_gamepad fade_out = true
    modal_controls.mode_index = 1
}


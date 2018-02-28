if instance_exists(modal_controls)
{
    with bn_cedit
    {
        fade_out = true
    }
    with bn_clabel
    {
        fade_out = true
    }
    with bn_restore_defaults fade_out = true
    with bn_use_keyboard fade_out = true
    with bn_use_gamepad fade_out = true
    modal_controls.mode_index = modal_controls.mode_index
}

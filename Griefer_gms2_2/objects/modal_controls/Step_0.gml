/// @description fade out intelligently
event_inherited()

//printf("::: global.using_gamepad = "+string(global.using_gamepad))

life++

header_text = header_texts[mode_index]
mode = modes[mode_index]

if fade_out or (not behave_match and menmode() != "settings")
{
    fade_out = true
    with bn_cedit fade_out = true
    with bn_clabel fade_out = true
    with bn_restore_defaults fade_out = true
    with bn_use_keyboard fade_out = true
    with bn_use_gamepad fade_out = true
    with bn_match_settings fade_out = true
    with bn_match_quit fade_out = true
    with bn_gen_settings fade_out = true
    with bn_control_settings fade_out = true
    with bn_logout_settings fade_out = true
}
else if life > 20
{ 
    //not fading out
    if not instance_exists(bn_cedit) and mode_index = 2
    {
        regen_cedits(FL_CEDITS)
    }
    else if not instance_exists(bn_cedit) and mode_index = 1
    {
        regen_cedits(FL_GEN_SETTINGS)
    }
    else if not instance_exists(bn_match_quit) and mode_index = 0
    {
        regen_cedits(FL_MATCH_SETTINGS)
    }
}


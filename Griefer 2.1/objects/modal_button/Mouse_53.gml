/// @description bail if there is a modal dialogue and this isn't part of it
if not force_click and instance_exists(modal_dialogue) and object_index != bn_dialogue
    exit

if modal_highlighted(id) and submit_action != scr_none and script_exists(submit_action)
{
    audio(snd_keystroke,1)
    script_execute(submit_action)
    if submit_fade
        fade_out = true
}


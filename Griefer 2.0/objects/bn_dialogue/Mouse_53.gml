/// @description vote for maps or random
if not modal_highlighted(id) and not force_enter
{
    exit_child = true
    exit
}

if force_enter
    force_enter = false

if clicked exit
    clicked = 2

if instance_exists(parent_dialogue) and script_exists(script)
{
    script_execute(script)
    if not parent_dialogue.is_input_field
    {
        parent_dialogue.fade_out = true
        fade_out = true
    }
}


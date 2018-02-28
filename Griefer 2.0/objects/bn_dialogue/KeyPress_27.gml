/// @description perform left press
if instance_exists(parent_dialogue) and parent_dialogue.bn_yes != id
{
    printf("pressed enter")
    force_enter = true
    event_perform(ev_mouse,ev_global_left_press)
}


/// @description vote for maps or random
if not modal_highlighted(id)
{
    exit_child = true
    exit
}

if clicked exit
    clicked = 2

if instance_exists(myAvatar()) and clickable
{
    audio(snd_click,1)
    
    with myAvatar()
    {
        varWrite("nextMapVote",other.map_num)
        obj_update_real(id,"nextMapVote",FL_NORMAL)
    }
    
    with bn_ready
    {
        get_ready(true)
    }
    
    recompute_votes()
}


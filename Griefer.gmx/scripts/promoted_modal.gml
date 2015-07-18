///promoted_modal(x,y,halign,valign,scale,your_avatar)
var dx = argument0
var dy = argument1
var halign = argument2
var valign = argument3
var scale = argument4
var av = argument5

if not instance_exists(av) or not is_my_avatar(av) 
{
    printf("ERROR: promoted modal couldn't find your avatar")
    return false
}

var xpos = dx
var ypos = dy
var av_head_yoff = view_hview*1/4
var blah_xoff = -64
if in_match()
    fade_delay = 3*room_speed
else
    fade_delay = 3*room_speed

{
    scale = 1.5
    //twidth = get_head_namerank_width("Promoted",scale)
    
    /*// Avatar Head
    ID = instance_create(xpos-twidth/2,ypos+av_head_yoff,action_word)
    ID.fade_delay = fade_delay
    ID.image = av
    ID.stick_2view = true  
    ID.scale = scale
    ID.init_as_promoted = true*/
    
    // "Promoted"
    with (action_word)
    {
        if init_as_promoted
            instance_destroy()
    }
    
    ID = instance_create(xpos/*+get_head_width(scale)-twidth/2*/,ypos+view_hview*1/4,action_word)
    ID.fade_delay = fade_delay
    ID.stick_2view = true
    ID.fnt = fnt_promoted
    if in_match()
        ID.col = c_white
    else
        ID.col = c_black
    ID.txt = "Promoted"
    ID.scale = 1
    ID.init_as_promoted = true
    ID.halign = fa_center
    ID.birth_delay = 5
    ID.pop_sound = snd_promoted
    
    
    // Rank + New Rank Name
    ID = instance_create(xpos,ypos+view_hview*1/4+96,action_word)
    ID.fade_delay = fade_delay
    ID.stick_2view = true
    ID.drawing_namerank = true
    ID.txt = rank
    ID.vmov = 0
    ID.scale = 1.5
    ID.init_as_promoted = true
    ID.halign = fa_center
    ID.birth_delay = 5
}

return ID

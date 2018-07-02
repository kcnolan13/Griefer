/// @description draw your vote
event_inherited()

if clickable
{
    if instance_exists(myAvatar()) and objVarRead(myAvatar(),"nextMapVote") = map_num
    {
        depth = -2
        //draw_notification("!",other.x-other.width/2,other.y-other.height/2,1.5,c_ltgray,1)
        border_width = 2
        border_alpha = 1
        text_color = web_hsv(218,33,100)
        border_color = c_white
    }
    else
    {
        text_color = c_white
        depth = -1
        if modal_highlighted(id)
        {
            border_width = 2
            border_alpha = 1
            border_color = c_white
        }
        else 
        {
            border_width = 1
            border_alpha = 0.5
            border_color = c_black
        }
    }
}


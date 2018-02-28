/// @description no double clicking
event_inherited()
label = text

if object_index != bn_postmatch_done
{
    if active
    {
        draw_gradient = false
        if sat > 25 
        {
            img_blend = c_white
            text_color = c_white
        }
        else
        {
            img_blend = c_black
            text_color = c_black
        }
    }
    else
    {
        grad1 = c_dkgray
        grad2 = c_dkgray
        grad3 = c_black
        grad4 = c_black
        draw_gradient = true
        img_blend = active_color
        text_color = c_white
    }
}


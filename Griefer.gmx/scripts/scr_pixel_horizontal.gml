amount = argument0
id_2way_hor = -1

repeat (abs(hsp))
    {
        if object_index = player
            res = 1
        else
            res = 4.5
        
        if scr_pixel_hor_sub(res) = false
        {hsp = 0 break}
    }
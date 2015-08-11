amount = argument0

/*id_moving = collision_rectangle(bbox_left,bbox_bottom-5+amount*sign(vsp),bbox_right,bbox_bottom+1+amount*sign(vsp),block2,true,true)
if id_moving > 0
{
    if id_moving.moving = true
    {standing_2way = true return true}
}*/

repeat(abs(real_speed(vsp)))
    {
        id_two_way = collision_rectangle(bbox_left,bbox_bottom-5+amount*sign(vsp),bbox_right,bbox_bottom+1+amount*sign(vsp),block2_top_true,true,true)
        if id_two_way > 1
        {
            if id_two_way.sprite_index = spr_block2
            {
                if id_two_way.state = "top" && vsp > 0 && bbox_bottom <= id_two_way.y
                {vsp = 0 standing_2way = true break}
            }
            else
            {
                above = false
                scr_compute_above(id_two_way)
                if id_two_way.state = "top" && vsp > 0 && above = true
                {vsp = 0 standing_2way = true break}
            }
        }
        if collision_rectangle(bbox_left,bbox_top+amount*sign(vsp),bbox_right,bbox_bottom+amount*sign(vsp),block,true,true)
        {vsp = 0; break;}
        else
        y+= sign(vsp)
    }

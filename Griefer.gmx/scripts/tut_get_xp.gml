add_xp(global.xp_tutorial,true,false,"")
ID = instantiate_bpart(spr_basic_helmet,"Tutorial",global.cache)
ID.new = true

with modal_button
{
    blocked = false
}


scheduler_queue(tut_violence,60)

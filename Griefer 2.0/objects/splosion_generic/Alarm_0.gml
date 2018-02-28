/// @description deal damage (only if local)
/// @function deal damage 
/// @param only if local
//create rubble
dat_rubble = instance_create(x,y,rubble_obj)
dat_rubble.xscale = xscale/2.5
dat_rubble.yscale = yscale/2.5

from_player = find_player(varRead("senderId"))

if object_index = splosion_ink exit

if not varRead("local") and not net_manager.bot_match
{
    if DEBUG
        printf("abstaining from explosion damage computation: NOT LOCAL")
    
    return false
}

if objVarRead(net_manager,"end_match_coming")
{
    exit
}

if not is_bot(from_player)
    challenge_manager.frag_kills = 0
    
for (var i=0; i<instance_number(player); i++)
{
    dat_playa = instance_find(player,i)
    if (not are_teammates(dat_playa, from_player) or dat_playa = from_player) 
    and dat_playa.die_timer=0 and objVarRead(dat_playa,"visible")
        damage_splosion()
}

if object_index != splosion_flame and object_index != splosion_smoke
        and object_index != splosion_ink and object_index != splosion_snare
        and object_index != splosion_flashbang
        and object_index != splosion_flame_instant
{
    for (var i=0; i<instance_number(rag_generic); i++)
    {
        dat_rag = instance_find(rag_generic,i)
        if point_distance(x,y,dat_rag.x,dat_rag.y) < radius and (not collision_line(x,y,dat_rag.x,dat_rag.y,block,true,false) and not collision_line(x,y,dat_rag.x,dat_rag.y,block2_top,true,false))
        {
            dat_rag.xfor = trigx(FORCE_SPLOSION*2,point_direction(x,y,dat_rag.x,dat_rag.y))
            dat_rag.yfor = trigy(FORCE_SPLOSION*2,point_direction(x,y,dat_rag.x,dat_rag.y))
            
            //if random(1) < 0.2
              //  bloodspray_player(dat_rag.x,dat_rag.y,75,random(360),dat_rag.blood_color)
                    
            with (dat_rag)
            {
                //sometimes fracture
                if random(1) < 0.25
                {
                    var loops = 0
                    for (var i=0; i<getLength(joints); i++)
                    {
                        if joints[i] != NO_HANDLE
                        {
                            if not audio_is_playing(snd_gnashed)
                                audio(snd_gnashed,0.65)
                            printf(":::disconnecting joint "+string(i))
                            physics_joint_delete(joints[i])
                            bleed_time = random_range(4*30,5*30)
                            bleed_strength_delay = bleed_time*2/3
                            bleed_strength_dec = 0.25
                            bleed_strength = random_range(16,18)
                            joints[i] = NO_HANDLE
                        }
                        loops++
                        if loops > 10
                            break
                    }
                    joints = 0
                    joints[0] = NO_HANDLE
                }
            
                physics_apply_force(x,y,xfor,yfor)
            }
        }
    }   
}


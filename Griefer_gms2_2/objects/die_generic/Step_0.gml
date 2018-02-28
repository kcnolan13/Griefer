/// @description CREATE THE RAGDOLL!

event_inherited()

if truthval(global.gc[GC_RAGDOLLS,1])
{
    
    animation_die()
    varWrite("animation_speed",0)
    varWrite("animation_index",0)

    if not created_rag and varRead("can_die")
    {   
        visible = false
        varWrite("visible",false)
        created_rag = true
        rag_fdir = varRead("hit_dir")
        rag_frac_prob = 0
        
        //simple_popup("fdir",string(rag_fdir))
        
        if varRead("die_shotgun")
        {
            rag_force = random_range(2,4)
            rag_frac_prob = 0.45
            audio(snd_gnashed,1)
        } else if varRead("die_splosion")
        {
            rag_force = random_range(FORCE_SPLOSION-1,FORCE_SPLOSION+1)
            rag_frac_prob = 0.35
            audio(snd_gnashed,1)
            //audio(snd_gnashed,2)
        } else if varRead("die_headshot")
        {
            rag_force = 8
            rag_fdir = 90
            audio(snd_headshot,1)
            rag_exclusions[RAG_HEAD] = true
        } else
        {
            rag_force = 14
        }
        
        //override rag force sometimes
        if varRead("hit_force") != FL_NO_FORCE
        {
            rag_force = real(varRead("hit_force"))
        }
        
        if not truthval(global.gc[GC_VIOLENT_CONTENT,1])
        {
            rag_frac_prob = 0
            rag_exclusions[RAG_HEAD] = false
        }
        rag_create_doll(rag_frac_prob,rag_force,rag_fdir)
    }
    
    //stick to the torso object
    if created_rag
    {
        if instance_exists(rags[RAG_TORSO])
        {
            x = rags[RAG_TORSO].x
            y = rags[RAG_TORSO].y
        }
        else
        {
            instance_destroy()
            exit
        }
    }
}
else 
{
    scr_basic_physics()
    
    if varRead("can_die")
    {
        if varRead("die_headshot")
        {
            audio(snd_headshot,1)
            animation_die_headshot()
            varWrite("animation_speed",SPD_DIE_HEADSHOT)
            varWrite("animation_index",0)
            varWrite("die_headshot",false)
            image_alpha = 10
            
            track_head = true
            blood_streamer = spray_blood(x,y,4,90,0.5,4.5*room_speed,1.25,20,1,6,varRead("blood_color"))
            if not instance_exists(blood_streamer) and truthval(global.gc[GC_PARTICLES,1])
            {
                printf("ERROR: blood_streamer does not exist")
            }
            else
            {
                blood_streamer.part_override = true
            }
        }
        else
        {
            animation_die()
            varWrite("animation_speed",SPD_DIE)
            varWrite("animation_index",0)
            image_alpha = 10
            blood_streamer = spray_blood(x,y,3,0,1,2.6*room_speed,1.25,16,2,1,varRead("blood_color"))
            if not instance_exists(blood_streamer) and truthval(global.gc[GC_PARTICLES,1])
                printf("ERROR: blood_streamer does not exist")
        }
        
        varWrite("can_die",false)
    }
    
    if varRead("animation_index") >= varRead("animation_length") - 2
    {
        varWrite("animation_index",varRead("animation_length")-1)
        varWrite("animation_speed",0)
    }
    
    if varRead("animation_speed") = 0
    {
        image_alpha -= 0.05
        if (image_alpha < 0.05)
        {
            instance_destroy()
            exit
        }
    }
    
    if instance_exists(blood_streamer)
    {
        blood_streamer.x = x
        blood_streamer.y = y
        
        blood_streamer.x = x+torso_x+varRead("animation_scale")*varRead("animation_xscale")*torso_xoffset
        blood_streamer.y = y+torso_y+varRead("animation_scale")*torso_yoffset
        
        if track_head
        {
            blood_streamer.spd /= 1.02
            blood_streamer.x = x+torso_x+varRead("animation_scale")*varRead("animation_xscale")*torso_xoffset+trigx(10*varRead("animation_xscale"),-1*torso_rot+90)
            blood_streamer.y = y+torso_y+varRead("animation_scale")*torso_yoffset+trigy(10,-1*torso_rot+90)
            blood_streamer.dir = -1*torso_rot+90
            if DEBUG
            {
                printf("tracking head --> spawned "+blood_streamer.particles_spawned+" particles so far @ "+blood_streamer.x+", "+blood_streamer.y)
                printf("dir = "+blood_streamer.dir)
            }
            
            if varRead("animation_xscale") = -1
                blood_streamer.dir = 180 - blood_streamer.dir
                
            if varRead("animation_index") > 15
            {
                blood_streamer.y -= 5
            }
                
        } else {
            
            desired_dir = (-1*torso_rot) mod 360
            if varRead("animation_index") > 15
            {
                desired_dir += 180
                blood_streamer.spd /= 1.0325
                blood_streamer.y -= 10
            }
            
            if varRead("animation_xscale") = -1
                desired_dir = 180 - desired_dir
            
            blood_streamer.dir = desired_dir
            
        }
    }
    
}


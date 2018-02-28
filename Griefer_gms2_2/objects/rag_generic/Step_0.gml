/// @description fade out and bleed
event_inherited()

life++

//FADE OUT CONTROL
if fade_delay
{
    fade_delay --
}
else
{
    image_alpha -= alpha_dec
    if image_alpha < 0.05
        instance_destroy()
}

if fps < 25
{
    if fade_delay and dice_real(0.1)
        fade_delay = 0
        
    if image_alpha < 0.5 and not fade_delay and instance_number(rag_generic) > 8 and dice_real(0.1)
    {
        instance_destroy()
        exit   
    }
}

//STREAM BLOOD
if bleed_strength_delay
{
    bleed_strength_delay --
}
else
{
    bleed_strength -= bleed_strength_dec
    if bleed_strength < 1
        bleed_strength = 1
}

//BLEED
for (var i=0; i<getLength(joint_xs); i++)
{
    aoff = 3
    strength_mult = 1
    blood_parts = 1
    dir_override = false
    if object_index = rag_torso
    {
        if life > 30/2 and (is_bound[0] or i > 0)
        {
            //spray everywhere
            aoff = random_range(-20,20)
        }
        else if i=0 and not is_bound[0]
        {
            aoff = 2
            strength_mult = 3.5
            blood_parts = 3
            bleed_time += 0.9
            dir_override = 90
        }
    }
    else
    {
        aoff = random_range(-1,1)
    }
    
    if object_index = rag_forearm
        aoff = 180
        
    jxs[i] = trigx(point_distance(0,0,joint_xs[i],joint_ys[i]),joint_dirs[i]+image_angle)
    jys[i] = trigy(point_distance(0,0,joint_xs[i],joint_ys[i]),joint_dirs[i]+image_angle)

    if not is_bound[i] and bleed_time
    {
        repeat(1)
        {
            if (fps > 25 or dice_real(0.25)) and instance_number(blood_particle) < MAX_PARTS
            {
                bleed_time --
                ID = instance_create(x+jxs[i],y+jys[i],blood_particle)
                if not dir_override
                    ID.dir = point_direction(x,y,joint_xs[i],joint_ys[i])+image_angle+aoff
                else
                    ID.dir = dir_override+image_angle+aoff
                ID.blend = blood_color
                var spd = bleed_strength*strength_mult
                {
                    ID.spd = spd
                    ID.hsp = trigx(spd,ID.dir)
                    ID.vsp = trigy(spd,ID.dir)
                }
            }
        }
    }
}

///get pushed by bullets and explosions and whatnot
if bullet_pushed
    bullet_pushed --
    
if instance_place(x,y,bullet_generic) and not bullet_pushed
{
    datBullet = instance_place(x,y,bullet_generic)
    if not instance_exists(datBullet) return false
    
    bullet_pushed = 2
    dmg = objVarRead(datBullet,"damage_body")
    
    if datBullet.object_index = bullet_shotgun or datBullet.object_index = bullet_double
        dmg *= 3
        
    //if random(1) < 0.15
      //  bloodspray_player(x,y,75,objVarRead(datBullet,"direction"),blood_color)
        
    bleed_time += dmg
    joint_health -= dmg
    force = dmg*1.25
    fdir = real(objVarRead(datBullet,"direction"))
    //printf("::: dmg="+string(dmg)+", joint_health="+string(joint_health))
    
    if joint_health <= 0 and random(1) < 0.15
    {
        var loops = 0
        //printf("::: trying to disconnect joints ... joints length = "+string(getLength(joints)))
        for (var i=0; i<getLength(joints); i++)
        {
            //printf(":::disconnecting joint "+string(i))
            if joints[i] != NO_HANDLE
            {
                physics_joint_delete(joints[i])
                bleed_time = random_range(4*30,5*30)
                bleed_strength_delay = bleed_time*2/3
                bleed_strength_dec = 0.25
                bleed_strength = random_range(16,18)
                joints[i] = NO_HANDLE
                if not audio_is_playing(snd_gnashed)
                    audio(snd_gnashed,0.25)
            }
            loops++
            if loops > 10
                break
        }
        joints = 0
        joints[0] = NO_HANDLE
    }

    physics_apply_force(x,y,trigx(force,fdir),trigy(force,fdir))
}

///constrict physics speed
constrict_physics_speed(real_speed(max_speed),real_speed(max_vang))


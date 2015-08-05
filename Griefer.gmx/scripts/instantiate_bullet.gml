///instantiate_bullet()
//MUST BE CALLED FROM A BULLET
///hitscan --> only computed by the player who shot the bullet

if bounces = 0
    audio(varRead("sound"),1)

if (not is_local_player_uid(varRead("senderId")) and not object_index = bullet_torque) and not is_bot(find_player(varRead("senderId")))
    return false
    
//if object_index = bullet_torque printf("instantiating torque bullet: speed = "+varRead("speed")+", direction = "+varRead("direction"))

image_angle = varRead("direction")

//initial collision check
if not varRead("is_bullet")
{
    /*//we are dealing with a tossable
    hsp = trigx(varRead("speed"),varRead("direction"))
    vsp = trigy(varRead("speed"),varRead("direction"))
    dir = varRead("direction")
    grav = varRead("gravity")
    recalc_tossable_vector()
    
    var inst = collision_line_first(varRead("startX"), varRead("startY"), varRead("myX") + hsp, varRead("myY") + vsp, solid_generic, true,true)
    if inst //and not have_hit_target
    {
        if DEBUG
            printf("CREATE EVENT Hitbouncing Tripped")
            
        hit_bounce_target(inst,collision_x,collision_y)
    }*/
    
    if object_index = bullet_torque and varRead("hitscan")
    {
        if bounces = 0
            muzzle_off = -75
        else
            muzzle_off = 0
            
        var scanx_i = varRead("myX")+trigx(muzzle_off,varRead("direction"))
        var scany_i =  varRead("myY")+trigy(muzzle_off,varRead("direction"))
        var scanx_f = varRead("myX")+trigx(varRead("speed"),varRead("direction"))
        var scany_f = varRead("myY")+trigy(varRead("speed"),varRead("direction"))
    
        var inst = hitscan_targets(scanx_i,scany_i, scanx_i + lengthdir_x(sqrt(room_width*room_width+room_height*room_height), varRead("direction")), scany_i + lengthdir_y(sqrt(room_width*room_width+room_height*room_height), varRead("direction")), shootable_generic, true,true, find_player(varRead("senderId")))
        
        if inst
        {
            dir_perm = point_direction(x,y,collision_x,collision_y)
            //if DEBUG
            //printf("INITIAL TORQUE COLLISION HIT with object "+inst.object_index+" @ ("+collision_x+", "+collision_y+")")
            dist = point_distance(x, y, collision_x, collision_y)
            
            backtrack = 0
            if bounces > 0
                backtrack = 32
            create_hitscan_flash(flash_hitscan_simple_torque,varRead("myX")+trigx(backtrack,varRead("direction")+180),varRead("myY")+trigy(backtrack,varRead("direction")+180),dist/100+backtrack/100,0.5,varRead("direction"))
            
            if bounces >= max_bounces
                hit_target(inst,collision_x,collision_y)
            else 
            {
                spd = 100
                dir = varRead("direction")
                printf("hitbouncing")
                hit_bounce_target(inst,collision_x,collision_y)
            }
            
            if inst.object_index != player
            {
                if bounces >= max_bounces
                {
                    //audio_play_sound(snd_sticky_stuck,2,false)
                    stuck = true
                    stuck_xoff = x
                    stuck_yoff = y
                    have_hit_target = true
                }
                else
                {
                    bounces++
                    instantiate_bullet()
                }
            } else 
            {
                if varRead("local")
                    play_stick_sound()
                    
                printf("TORQUE STUCK!!!")
                
                if varRead("local") and bounces > 0
                {
                    challenge_manager.torque_kills++
                }
                have_hit_target = true
                stuck_player = inst
                stuck_xoff = 0//x - inst.x
                stuck_yoff = y - inst.y
                stuck_xscaler = objVarRead(inst,"animation_xscale")
                stuck = true
                stuck_ang = inst.torso_rot*-1
            }
        }
        else
        {
            //if bounces > 0
            {
                have_hit_target = true
                stuck = true
                stuck_xoff = x
                stuck_yoff = y
                bounces = max_bounces
            }
            /*else
            {
                if DEBUG
                printf("no collision found!!")
                create_hitscan_flash(flash_hitscan_simple_torque,varRead("myX"),varRead("myY"),3072/100,0.5,varRead("direction"))
                varAdd("myX", lengthdir_x(3072, varRead("direction")))
                varAdd("myY",lengthdir_y(3072, varRead("direction")))
            }*/
        }
    }
}
else
{
    muzzle_off = -63
    if object_index = bullet_shotgun or object_index = bullet_double
        muzzle_off = -90
        
    if object_index = bullet_lmg
        muzzle_off = -75
        
    if object_index = bullet_rifle
        muzzle_off = -72
        
    var scanx_i = varRead("myX")+trigx(muzzle_off,varRead("direction"))
    var scany_i =  varRead("myY")+trigy(muzzle_off,varRead("direction"))
    var scanx_f = varRead("myX")+trigx(varRead("speed"),varRead("direction"))
    var scany_f = varRead("myY")+trigy(varRead("speed"),varRead("direction"))
    
    if not varRead("hitscan")
    {
        if DEBUG
        {
            ID = instance_create(scanx_i, scany_i, hit_marker)
            ID.image_blend = c_teal
            objVarWrite(ID,"image_blend",c_teal)
            
            ID = instance_create(scanx_f, scany_f, hit_marker)
            ID.image_blend = c_red
            objVarWrite(ID,"image_blend",c_red)
        }
        
        var inst = hitscan_targets(scanx_i, scany_i, scanx_f, scany_f, shootable_generic, true,true, find_player(varRead("senderId")))
        if inst
        {
            if DEBUG
                printf("INITIAL COLLISION HIT!")
            hit_target(inst,collision_x,collision_y)
        }
        else
        {
            if DEBUG
                printf("NO HIT found from ("+scanx_i+", "+scany_i+") to ("+scanx_f+", "+scany_f+")")
        }
    }
    else
    {
        var inst = hitscan_targets(scanx_i,scany_i, scanx_i + lengthdir_x(sqrt(room_width*room_width+room_height*room_height), varRead("direction")), scany_i + lengthdir_y(sqrt(room_width*room_width+room_height*room_height), varRead("direction")), shootable_generic, true,true, find_player(varRead("senderId")))
        if inst
        {
            if DEBUG
                printf("INITIAL COLLISION HIT with object "+inst.object_index+" @ ("+collision_x+", "+collision_y+")")
            dist = point_distance(x, y, collision_x, collision_y)
            create_hitscan_flash(varRead("flash_hitscan"),varRead("myX"),varRead("myY"),dist/100,0.5,varRead("direction"))
            hit_target(inst,collision_x,collision_y)
        }
        else
        {
            if DEBUG
                printf("no collision found!!")
            create_hitscan_flash(varRead("flash_hitscan"),varRead("myX"),varRead("myY"),3072/100,0.5,varRead("direction"))
            varAdd("myX", lengthdir_x(3072, varRead("direction")))
            varAdd("myY",lengthdir_y(3072, varRead("direction")))
        }
    }
    
    //update the bullet for other players
    obj_update_real(id,"myX",FL_NORMAL)
    obj_update_real(id,"myY",FL_NORMAL)
    obj_update_real(id,"speed",FL_NORMAL)
}

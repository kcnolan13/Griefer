///instantiate_bullet()
//MUST BE CALLED FROM A BULLET
///hitscan --> only computed by the player who shot the bullet

if bounces = 0
    audio(varRead("sound"),1)
    
if not is_string(varRead("senderId"))
{
    printf("WARNING: "+object_get_name(object_index)+" has non-string senderId: "+string(varRead("senderId")))
}

if (not is_local_player(varRead("senderId")) and (not object_index = bullet_torque)) and (not is_bot(find_player(varRead("senderId"))))
    return false
    
//if object_index = bullet_torque printf("instantiating torque bullet: speed = "+varRead("speed")+", direction = "+varRead("direction"))

image_angle = varRead("direction")

//initial collision check
if (not varRead("is_bullet"))
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
        var from_player = find_player(varRead("senderId"))
        var inst = noone
        if instance_exists(from_player) and from_player.object_index = player
        {
            inst = hitscan_targets(scanx_i,scany_i, scanx_i + lengthdir_x(sqrt(room_width*room_width+room_height*room_height), varRead("direction")), scany_i + lengthdir_y(sqrt(room_width*room_width+room_height*room_height), varRead("direction")), shootable_generic, true,true, from_player)
        } else printf("ERROR: hitscan during instantiate bullet trying to use from_player="+string(from_player))
        
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
                    stuck = true
                    stuck_xoff = x
                    stuck_yoff = y
                    have_hit_target = true
                    varWrite("stuck_xoff",x)
                    varWrite("stuck_yoff",y)
                    
                    //get stuck to nothing and tell other players about it
                    varWrite("stuck_pname","sticky_projectile_stuck_on_block")
                    varWrite("can_rotate",false)
                    obj_update_string(id,"stuck_pname",FL_NORMAL)
                    obj_update_real(id,"stuck_xoff",FL_NORMAL)
                    obj_update_real(id,"stuck_yoff",FL_NORMAL)
                    obj_update_real(id,"can_rotate",FL_NORMAL)
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
                stuck = true
                varWrite("stuck_pname",string(playerName(inst)))
                varWrite("stuck_xoff",0)
                varWrite("stuck_yoff",y-inst.y)
                varWrite("stuck_xscaler",objVarRead(inst,"animation_xscale"))
                varWrite("stuck_ang",inst.torso_rot*-1)
                varWrite("can_rotate",false)
                
                //broadcast to other players that this nade is stuck and to whom it is bound
                obj_update_string(id,"stuck_pname",FL_NORMAL)
                obj_update_real(id,"stuck_xoff",FL_NORMAL)
                obj_update_real(id,"stuck_yoff",FL_NORMAL)
                obj_update_real(id,"stuck_xscaler",FL_NORMAL)
                obj_update_real(id,"stuck_ang",FL_NORMAL)
                obj_update_real(id,"can_rotate",FL_NORMAL)
            }
        }
        else
        {
            //won't need to bounce again
            if bounces < max_bounces
                do_next_instantiate = true
            else
                do_next_instantiate = false
                
            bounces += 100
            
            if do_next_instantiate
            {
                instantiate_bullet()
            }
            else
            {
                stuck = true
                stuck_xoff = scanx_i + lengthdir_x(sqrt(room_width*room_width+room_height*room_height), varRead("direction"))
                stuck_yoff = scany_i + lengthdir_y(sqrt(room_width*room_width+room_height*room_height), varRead("direction"))
                
                have_hit_target = true
                varWrite("stuck_xoff",stuck_xoff)
                varWrite("stuck_yoff",stuck_yoff)
                
                //get stuck to nothing and tell other players about it
                varWrite("stuck_pname","sticky_projectile_stuck_on_block")
                varWrite("can_rotate",false)
                obj_update_string(id,"stuck_pname",FL_NORMAL)
                obj_update_real(id,"stuck_xoff",FL_NORMAL)
                obj_update_real(id,"stuck_yoff",FL_NORMAL)
                obj_update_real(id,"can_rotate",FL_NORMAL)
            }
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
        var from_player = find_player(varRead("senderId"))
        var inst = noone
        
        if instance_exists(from_player) and from_player.object_index = player
        {
            inst = hitscan_targets(scanx_i, scany_i, scanx_f, scany_f, shootable_generic, true,true, from_player)
        } else printf("ERROR: hitscan during instantiate bullet trying to use from_player="+string(from_player))
        
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
        var from_player = find_player(varRead("senderId"))
        var inst = noone
        
        if instance_exists(from_player) and from_player.object_index = player
        {
          inst = hitscan_targets(scanx_i, scany_i, scanx_i + lengthdir_x(sqrt(room_width*room_width+room_height*room_height), varRead("direction")), scany_i + lengthdir_y(sqrt(room_width*room_width+room_height*room_height), varRead("direction")), shootable_generic, true, true, from_player)
        } else printf("ERROR: hitscan during instantiate bullet trying to use from_player="+string(from_player))
        
        if inst
        {
            printf(":::INITIAL COLLISION HIT with object "+string(inst.object_index)+" @ ("+string(collision_x)+", "+string(collision_y)+")")
            dist = point_distance(x, y, collision_x, collision_y)
            create_hitscan_flash(varRead("flash_hitscan"),varRead("myX"),varRead("myY"),dist/100,0.5,varRead("direction"))
            hit_target(inst,collision_x,collision_y)
        }
        else
        {
            printf("::: no collision found...")
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

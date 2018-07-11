/// @description jump to net x y and transform
depth = -96

image_angle = varRead("direction")
counter ++

if counter < 3 and varRead("local")
{
    //really make it known who the sender was
    obj_update_string(id,"senderId",FL_NORMAL)
}

if traj_draw
    visible = true

if abs(varRead("speed")) < 0.05 or (no_from_player and counter > 12)
{
    stationary_counter ++
    if stationary_counter > 2
    {
        instance_destroy()
        exit
    }
}

if not varRead("hitscan")
{
    if varRead("speed") > 0
    {
        if vsp = -999 or hsp = -999
        {
            hsp = trigx(varRead("speed"),varRead("direction"))
            vsp =  trigy(varRead("speed"),varRead("direction"))
            add_x = real_speed(hsp)
            add_y = real_speed(vsp)
        } else {
            //NORMAL CASE
            decel_x = trigx(varRead("deceleration"),varRead("direction"))
            decel_y = trigy(varRead("deceleration"),varRead("direction"))
            
            var test_speed = point_distance(x,y,x+real_speed(hsp),y+real_speed(vsp))
            
            if test_speed < real_speed(varRead("min_speed"))
            {
                decel_x = trigx(test_speed-varRead("min_speed"),varRead("direction"))
                decel_y = trigy(test_speed-varRead("min_speed"),varRead("direction"))
            }
            
            if test_speed > real_speed(varRead("max_speed"))
            {
                decel_x = trigx(varRead("max_speed")-test_speed,varRead("direction"))
                decel_y = trigy(varRead("max_speed")-test_speed,varRead("direction"))
            }
            
            hsp -= decel_x
            vsp += real_speed(varRead("gravity")) - decel_y
            varWrite("speed",point_distance(x,y,x+hsp,y+vsp))
            if abs(hsp) > 0.05 and abs(vsp) > 0.05
                varWrite("direction",point_direction(x,y,x+hsp,y+vsp))
            
            add_x = real_speed(hsp)
            add_y = real_speed(vsp)
        }
    } else 
    {
        add_x = 0
        add_y = 0
    }
    
    from_player = find_player(varRead("senderId"))
    
    if is_local_player(from_player) and counter > 1 and instance_exists(from_player) and from_player.object_index = player
    {
        no_from_player = false
        
        var inst = hitscan_targets(varRead("myX"), varRead("myY"), varRead("myX")+trigx(varRead("speed"),varRead("direction")), varRead("myY")+trigy(varRead("speed"),varRead("direction")), shootable_generic, true,true, from_player)
        if inst and not have_hit_target
        {
            if SUPER_DEBUG
                printf("Hitting Target from STEP EVENT")
            hit_target(inst,collision_x,collision_y)
        }
        else
        {
            varAdd("myX",add_x)
            varAdd("myY",add_y)
        }
    }
    else if instance_exists(from_player) and from_player.object_index = player
    {
        no_from_player = false
        
        var inst = hitscan_targets(varRead("myX"), varRead("myY"), varRead("myX")+trigx(varRead("speed"),varRead("direction")), varRead("myY")+trigy(varRead("speed"),varRead("direction")), shootable_generic, true,true, from_player)
        if inst
        {
            varWrite("speed",0)
            varWrite("myX",collision_x)
            varWrite("myY",collision_y)
        } else
        {
            varAdd("myX",add_x)
            varAdd("myY",add_y)
        }
    }
    else if counter > 10
    {
        printf("ERROR: from_player does not exist in bullet_generic step ... senderId="+string(varRead("senderId"))+", from_player="+string(from_player))
        no_from_player = true
    }
}

x = varRead("myX")
y = varRead("myY")

///hit blocks

datBlock = instance_place(x,y,block)
if instance_exists(datBlock)
{
    hit_block(datBlock)
}

datBlock = instance_place(x,y,block2_top)
if instance_exists(datBlock)
{
    hit_block(datBlock)
}

if not instance_exists(id)
    exit


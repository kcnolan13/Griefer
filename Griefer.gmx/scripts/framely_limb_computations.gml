///framely_limb_computations()

if varRead("animation_index") >= varRead("animation_length") or varRead("animation_index") < 0
{
    if varRead("animation_index") >= varRead("animation_length")
        varWrite("animation_index",0)
    else
        varWrite("animation_index",varRead("animation_length") -1)
}

//CHANGE THE WAY HE'S FACING
varWrite("animation",string(varRead("animation")))
varWrite("arm_pose",string(varRead("arm_pose")))

if instance_exists(cursor) and varRead("animation") != "die" and varRead("animation") != "die_headshot" and 
    (varRead("controllable") or 
    (not in_match() and (object_index = gravatar or string(varRead("pName")) = string(objVarRead(net_manager,"pName")))) 
    or (net_manager.local_player = id and net_manager.starting_match)) 
    and not slide_left and not slide_right
{
    pDir = point_direction(x,y,cursor.x,cursor.y) mod 360
    
    //bot aim override
    if is_bot(id)
        pDir = point_direction(x,y,xaim,yaim) mod 360
    
    if (pDir > 90) and (pDir < 270)
        varWrite("animation_xscale",-1)
    else
        varWrite("animation_xscale",1)
}

//TORSO
torso_x = varRead("animation_scale")*varRead("animation_xscale")*torso_xs[floor(varRead("animation_index"))]
torso_y = varRead("animation_scale")*torso_ys[floor(varRead("animation_index"))]
torso_rot = torso_rots[floor(varRead("animation_index"))]

//HEAD
head_x = varRead("animation_scale")*varRead("animation_xscale")*head_xs[floor(varRead("animation_index"))]
head_y = varRead("animation_scale")*head_ys[floor(varRead("animation_index"))]
head_rot = head_rots[floor(varRead("animation_index"))]

hat_x = varRead("animation_scale")*varRead("animation_xscale")*hat_xs[floor(varRead("animation_index"))]
hat_y = varRead("animation_scale")*hat_ys[floor(varRead("animation_index"))]
hat_rot = hat_rots[floor(varRead("animation_index"))]

//ARM POSES VS FULL-BODY ANIMATIONS
if (varRead("arms_posing"))
{
    
    //handle arm pose animations
    varAdd("arm_animation_index", varRead("arm_animation_speed")*varRead("arm_animation_direction"))
    
    if varRead("arm_animation_index") >= varRead("arm_animation_length") or varRead("arm_animation_index") < 0
    {
        //set nade animation speed to 0 please
        if varRead("arm_pose") = "nade"
            varWrite("arm_animation_speed",0)
            
        if varRead("arm_animation_index") >= varRead("arm_animation_length")
            varWrite("arm_animation_index",0)
        else
            varWrite("arm_animation_index",varRead("arm_animation_length") -1)
    }

    //printf(string(varRead("pName"))+"'s char_gen: "+string(varRead("arm_animation_index"))+" of "+string(varRead("arm_animation_length")))
    if array_length_1d(shoulderl_xs) < varRead("arm_animation_index")
    {
        printf("ERROR: array length shouldel_xs < arm_anim_index")
        varWrite("arm_animation_index",array_length_1d(shoulderl_xs)-1)
    }
    
    //THIS SECTION INCLUDES TRIG CODE FOR MOUSE LOOKING X, Y, ROT OFFSETS BASED ON SHOULDER JOINT ROT POINT
    shoulderl_x = varRead("animation_xscale")*(varRead("animation_scale")*shoulderl_xs[floor(varRead("arm_animation_index"))]+torso_x)
    shoulderl_y = varRead("animation_scale")*shoulderl_ys[floor(varRead("arm_animation_index"))]+torso_y+varRead("arm_y_extra")
    shoulderl_rot = shoulderl_rots[floor(varRead("arm_animation_index"))]+varRead("arm_rot_extra")

    shoulderr_x = varRead("animation_xscale")*(varRead("animation_scale")*shoulderr_xs[floor(varRead("arm_animation_index"))]+torso_x)
    shoulderr_y = varRead("animation_scale")*shoulderr_ys[floor(varRead("arm_animation_index"))]+torso_y+varRead("arm_y_extra")
    shoulderr_rot = shoulderr_rots[floor(varRead("arm_animation_index"))]+varRead("arm_rot_extra")
    
    forearml_x = varRead("animation_xscale")*(varRead("animation_scale")*forearml_xs[floor(varRead("arm_animation_index"))]+torso_x)
    forearml_y = varRead("animation_scale")*forearml_ys[floor(varRead("arm_animation_index"))]+torso_y+varRead("arm_y_extra")
    forearml_rot = forearml_rots[floor(varRead("arm_animation_index"))]+varRead("arm_rot_extra")
    
    forearmr_x = varRead("animation_xscale")*(varRead("animation_scale")*forearmr_xs[floor(varRead("arm_animation_index"))]+torso_x)
    forearmr_y = varRead("animation_scale")*forearmr_ys[floor(varRead("arm_animation_index"))]+torso_y+varRead("arm_y_extra")
    forearmr_rot = forearmr_rots[floor(varRead("arm_animation_index"))]+varRead("arm_rot_extra")
    
    weapon_x = forearmr_x
    weapon_y = forearmr_y
    weapon_xoffset = forearmr_xoffset+trigx(30,forearmr_rot)
    weapon_yoffset = forearmr_yoffset+trigy(30,forearmr_rot)
    weapon_rot = 0
    
    //ROTATE ARMS
    if instance_exists(cursor)
    {
        if varRead("animation_xscale") = -1
        {
            shoulderl_rot = 180 - shoulderl_rot
            shoulderr_rot = 180 - shoulderr_rot
            forearml_rot = 180 - forearml_rot
            forearmr_rot = 180 - forearmr_rot
            weapon_rot = 180 - weapon_rot
        }
                
        //ROTATE THE ARMS AND HEAD AND HAT AND SHIT
        if varRead("controllable") or (not in_match() and string(varRead("pName")) = string(objVarRead(net_manager,"pName"))) or (net_manager.local_player = id and net_manager.starting_match)
        {
            rot_true = (point_direction(x+torso_x,y+torso_y,cursor.x,cursor.y)) mod 360
            
            if is_bot(id)
                rot_true = (point_direction(x+torso_x,y+torso_y,xaim,yaim)) mod 360
                
            varWrite("rot_true",rot_true)
        }
        else
            rot_true = varRead("rot_true")
        
        rot_true = real(rot_true)
            
        //only do head and hat if not rolling
        if varRead("animation") != "roll"
        {
            head_roti = head_rot
            hat_roti = hat_rot
            
            if (rot_true < 90)
            {
                head_rot -= (rot_true-head_rot)/stiff_neck
                hat_adjust = (rot_true-hat_rot)/stiff_neck
                hat_rot  -= hat_adjust
            }
            else
            {
                head_rot -= (rot_true-360-head_rot)/stiff_neck
                hat_adjust = (rot_true-360-hat_rot)/stiff_neck
                hat_rot -= hat_adjust
            }
            
            if varRead("animation_xscale") = -1
            {
                rot_true = (rot_true+180) mod 360
                head_rot = (90 - head_rot) mod 360 + head_roti
                hat_rot = (90 - hat_rot) mod 360 + hat_roti
            }
            
            //printf("rot_true = "+rot_true)
            //printf("head_rot = "+head_rot)
            
            mag = point_distance(head_xoffset,head_yoffset,hat_xoffset,hat_yoffset)
            dir = point_direction(head_xoffset,head_yoffset,hat_xoffset,hat_yoffset)
            ang = dir-hat_rot
            
            
            hat_xoffset_temp = head_xoffset+trigx(mag,ang)
            hat_yoffset_temp = head_yoffset+trigy(mag,ang)
            
            //printf("hat_xoffset_temp = "+hat_xoffset_temp)
            //printf("hat_yoffset_temp = "+hat_yoffset_temp)
            
            //printf("ang = "+ang)
        } else {
            //make sure arm rotates in the right direction even when rolling
            if varRead("animation_xscale") = -1
                {
                    rot_true = (rot_true+180) mod 360
                }
        }
        
        shoulderl_rot -= rot_true
        shoulderr_rot -= rot_true
        forearml_rot -= rot_true
        forearmr_rot -= rot_true
        weapon_rot -= rot_true
        
        
        kick_xoffset = trigx(varRead("kick"),rot_true+180)*varRead("animation_xscale")
        kick_yoffset = trigy(varRead("kick"),rot_true+180)*varRead("animation_xscale")
        
        //xoffset and yoffset from the torso
            magr = point_distance(0,0,forearmr_xoffset,forearmr_yoffset)
            magl = point_distance(0,0,forearml_xoffset,forearml_yoffset)
            magw = point_distance(0,0,weapon_xoffset,0)
            
            dirr = point_direction(varRead("animation_xscale")*torso_xs[0],torso_ys[0],varRead("animation_xscale")*forearmr_xoffset,forearmr_yoffset)
            dirl = point_direction(varRead("animation_xscale")*torso_xs[0],torso_ys[0],varRead("animation_xscale")*forearml_xoffset,forearml_yoffset)
            dirw = point_direction(varRead("animation_xscale")*torso_xs[0],torso_ys[0],varRead("animation_xscale")*weapon_xoffset,weapon_yoffset)
            
            //rotate at the designated angle maintaining this magnitude offset from the origin
            forearmr_xoffset_temp = trigx(magr, rot_true+dirr)+kick_xoffset
            forearmr_yoffset_temp = trigy(magr, rot_true+dirr)+kick_yoffset
            forearml_xoffset_temp = trigx(magl, rot_true+dirl)+kick_xoffset
            forearml_yoffset_temp = trigy(magl, rot_true+dirl)+kick_yoffset
            
            if varRead("arm_pose") = "nade"
                wep_angle = (rot_true+180) mod 360
            else
                wep_angle = rot_true
            
            weapon_xoffset_temp = trigx(varRead("animation_xscale")*magw, wep_angle)+kick_xoffset
            weapon_yoffset_temp = trigy(varRead("animation_xscale")*magw, wep_angle)+kick_yoffset
            
            if wep_angle != rot_true
            {
                //you are dealing with a grenade --> shit sucks
                weapon_xoffset_temp = forearmr_xoffset_temp+trigx(32,-1*forearmr_rot)
                weapon_yoffset_temp = forearmr_yoffset_temp+trigy(32,-1*forearmr_rot)
            }
            
            
            /*if slide_left or slide_right
            {
                if slide_right
                {
                    if cursor.x > x
                        prescaler = 1
                    else
                        prescaler = -1
                } else if slide_left {
                    if cursor.x < x
                        prescaler = 1
                    else
                        prescaler = -1
                }
                
                weapon_y *= prescaler
                
            }*/
            
            magr = point_distance(0,0,shoulderr_xoffset,shoulderr_yoffset)
            magl = point_distance(0,0,shoulderl_xoffset,shoulderl_yoffset)
            dirr = point_direction(varRead("animation_xscale")*torso_xs[0],torso_ys[0],varRead("animation_xscale")*shoulderr_xoffset,shoulderr_yoffset)
            dirl = point_direction(varRead("animation_xscale")*torso_xs[0],torso_ys[0],varRead("animation_xscale")*shoulderl_xoffset,shoulderl_yoffset)
            
            shoulderr_xoffset_temp = trigx(magr, rot_true+dirr)+kick_xoffset
            shoulderr_yoffset_temp = trigy(magr, rot_true+dirr)+kick_yoffset
            shoulderl_xoffset_temp = trigx(magl, rot_true+dirl)+kick_xoffset
            shoulderl_yoffset_temp = trigy(magl, rot_true+dirl)+kick_yoffset          
            
            /*printf("dirr = "+dirr)
            printf("magr = "+magr)
            printf("shoulderr_xoffset_temp = "+shoulderr_xoffset_temp)
            printf("shoulderr_yoffset_temp = "+shoulderr_yoffset_temp)
            printf("forearmr_xoffset_temp = "+forearmr_xoffset_temp)
            printf("forearmr_yoffset_temp = "+forearmr_yoffset_temp)
            printf("shoulderr_rot = "+shoulderr_rot)
            printf("forearmr_rot = "+forearmr_rot)*/
        
    }

} else {
    hat_xoffset_temp = hat_xoffset
    hat_yoffset_temp = hat_yoffset
    forearmr_xoffset_temp = forearmr_xoffset
    forearmr_yoffset_temp = forearmr_yoffset
    forearml_xoffset_temp = forearml_xoffset
    forearml_yoffset_temp = forearml_yoffset

    shoulderr_xoffset_temp = shoulderr_xoffset
    shoulderr_yoffset_temp = shoulderr_yoffset
    shoulderl_xoffset_temp = shoulderl_xoffset
    shoulderl_yoffset_temp = shoulderl_yoffset
        
    //act like all the other.id pieces if part of a full-body animation
    if array_length_1d(shoulderl_xs) < varRead("arm_animation_index")
    {
        printf("ERROR: array length shoulderl_xs < arm_animation_index")
        varWrite("arm_animation_index",array_length_1d(shoulderl_xs)-1)
    }
    
    shoulderl_x = varRead("animation_scale")*varRead("animation_xscale")*shoulderl_xs[floor(varRead("animation_index"))]
    shoulderl_y = varRead("animation_scale")*shoulderl_ys[floor(varRead("animation_index"))]
    shoulderl_rot = shoulderl_rots[floor(varRead("animation_index"))]

    shoulderr_x = varRead("animation_scale")*varRead("animation_xscale")*shoulderr_xs[floor(varRead("animation_index"))]
    shoulderr_y = varRead("animation_scale")*shoulderr_ys[floor(varRead("animation_index"))]
    shoulderr_rot = shoulderr_rots[floor(varRead("animation_index"))]
    
    forearml_x = varRead("animation_scale")*varRead("animation_xscale")*forearml_xs[floor(varRead("animation_index"))]
    forearml_y = varRead("animation_scale")*forearml_ys[floor(varRead("animation_index"))]
    forearml_rot = forearml_rots[floor(varRead("animation_index"))]
    
    forearmr_x = varRead("animation_scale")*varRead("animation_xscale")*forearmr_xs[floor(varRead("animation_index"))]
    forearmr_y = varRead("animation_scale")*forearmr_ys[floor(varRead("animation_index"))]
    forearmr_rot = forearmr_rots[floor(varRead("animation_index"))]
}



//THE REST OF THE BODY

legl_x = varRead("animation_scale")*varRead("animation_xscale")*legl_xs[floor(varRead("animation_index"))]
legl_y = varRead("animation_scale")*legl_ys[floor(varRead("animation_index"))]
legl_rot = legl_rots[floor(varRead("animation_index"))]

legr_x = varRead("animation_scale")*varRead("animation_xscale")*legr_xs[floor(varRead("animation_index"))]
legr_y = varRead("animation_scale")*legr_ys[floor(varRead("animation_index"))]
legr_rot = legr_rots[floor(varRead("animation_index"))]

shinl_x = varRead("animation_scale")*varRead("animation_xscale")*shinl_xs[floor(varRead("animation_index"))]
shinl_y = varRead("animation_scale")*shinl_ys[floor(varRead("animation_index"))]
shinl_rot = shinl_rots[floor(varRead("animation_index"))]

shinr_x = varRead("animation_scale")*varRead("animation_xscale")*shinr_xs[floor(varRead("animation_index"))]
shinr_y = varRead("animation_scale")*shinr_ys[floor(varRead("animation_index"))]
shinr_rot = shinr_rots[floor(varRead("animation_index"))]

footl_x = varRead("animation_scale")*varRead("animation_xscale")*footl_xs[floor(varRead("animation_index"))]
footl_y = varRead("animation_scale")*footl_ys[floor(varRead("animation_index"))]
footl_rot = footl_rots[floor(varRead("animation_index"))]

footr_x = varRead("animation_scale")*varRead("animation_xscale")*footr_xs[floor(varRead("animation_index"))]
footr_y = varRead("animation_scale")*footr_ys[floor(varRead("animation_index"))]
footr_rot = footr_rots[floor(varRead("animation_index"))]

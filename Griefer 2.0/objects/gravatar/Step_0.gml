/// @description all dat ish
if mouse_wheel_delay > 0
mouse_wheel_delay --

if hover_counter
    cursor_highlight()

if nth_frame(60)
{
    if room = rm_login
    {
        dude_lerp = login_dude_lerp
    } 
    else
    {
        dude_lerp = 0.3
    }
}


if in_match()
{
    x = room_width+64*12
    y = -64*12
}
else if room = rm_lobby or room = rm_menu
{   
    //sync uniqueId up with your local avatar
    if instance_exists(net_manager.my_doll)
    {
        varWrite("uniqueId",objVarRead(net_manager.my_doll,"uniqueId"))
    }
    varWrite("pName",stat_manager.grav_name)
}
else if room = rm_login
{
    if login_lerp_delay_base
        login_lerp_delay_base --
        
    if rtime() > 5*30 and varRead("lerp_delay") > login_lerp_delay*varRead("pNum")
        varWrite("lerp_delay",login_lerp_delay*varRead("pNum"))
    
    var dude_x_new = room_width/2+global.xoff
    var pnum = varRead("pNum")
    var spacer = 64*2.75
    
    if pnum > 1 and pnum mod 2 = 0
    {
        dude_x_new -= pnum/2*spacer
    }
    else
    {
        dude_x_new += (pnum-1)/2*spacer
    }
    
    varWrite("dude_x",dude_x_new)
    
    if not bparts_done_ready or varRead("login_delay")
    {
        varWrite("login_delay",sub_real(varRead("login_delay"),1))
        varWrite("dude_y",1200)
    }
    else
    {
        if not net_manager.login_when_ready
        {
            varWrite("dude_y",room_height*4/5-48*(5-varRead("pNum")))
            if varRead("lerp_delay")
                y = 1200
        }
        else if not varRead("lerp_delay")
        {
            varWrite("dude_y",HVIEW+64*8)
        }
    }
}

if point_distance(x,y,cursor.x,cursor.y) < 64
{
    hover_counter++
    if room = rm_login
        varWrite("animation_scale",lerp(varRead("animation_scale"),scale_highlight,scale_lerp))
}
else
{
    hover_counter = 0
    if room = rm_login
        varWrite("animation_scale",lerp(varRead("animation_scale"),scale_normal,scale_lerp))
}

varWrite("animation_speed",SPD_STAND)

if not bparts_done_ready
{
    for (var i=0; i<1; i++)
    {
        if not bparts_ready[i] and (room != rm_login or id != net_manager.stat_gravatar)
        {
            bparts_ready[i] = bparts_get_ready(i)
        }
    }
    
    bparts_done_ready = true
    
    for (var i=0; i<1; i++)
    {
        if not bparts_ready[i]
            bparts_done_ready = false
    }
    
    if bparts_done_ready 
    {
    
        if room = rm_login
        {
            varWrite("lerp_delay",login_lerp_delay_base+login_lerp_delay*varRead("pNum"))
            dude_instalerp_x = true
        }
        else
        {
            stat_manager.grav_ready = true
            if (net_manager.stat_gravatar != id)
            {
                printf(":::WARNING: gravatar expected netman.stat_gravatar to be equal to his id in step_1")
            }
        }
        
        printf("::: all bparts ready for grav --> enable grav_ready in stat man!")
        varWrite("visible",true)
        visible = true
    }
}

if room = rm_menu or room = rm_lobby
{
    varWrite("arm_animation_speed",0)
    varWrite("arm_animation_index",0)
    sync_poses_and_animations()
    
    if menmode() != "stats" or stat_manager.stat_tab = stat_manager.tabs[2]
    {
        varWrite("dude_x",-64*12)
        varWrite("visible",false)
        visible = false
    } else
    {
        visible = true
        varWrite("visible",true)
    }
    
    if not bparts_done_ready
    {
        varWrite("visible",false)
        visible = false
    }
}

//printf("::: gravatar x ="+string(x)+", y ="+string(y)+", visible="+string(visible))

//INHERITED EVENT, OF COURSE
event_inherited()

///sync prop with active_weapon_sprite and arm_pose

if room = rm_menu or room = rm_lobby or room = rm_login
{
    varWrite("arm_animation_speed",0)
    varWrite("arm_animation_index",0)
    sync_poses_and_animations()
}

if real(varRead("prop0")) > 0 and room = rm_menu or room = rm_lobby or room = rm_login
{
    varWrite("active_weapon_sprite",varRead("prop0"))
    
    switch real(varRead("prop0"))
    {
        case spr_prop_none:
            varWrite("arm_pose",global.pistol_pose)
            varWrite("active_weapon_prescaler",global.pistol_scale)
        break
        
        case spr_prop:
            varWrite("arm_pose",global.pistol_pose)
            varWrite("active_weapon_prescaler",global.pistol_scale)
        break
        
        case spr_pistol:
            varWrite("arm_pose",global.pistol_pose)
            varWrite("active_weapon_prescaler",global.pistol_scale)
        break
        
        case spr_rifle:
            varWrite("arm_pose",global.rifle_pose)
            varWrite("active_weapon_prescaler",global.rifle_scale)
        break
        
        case spr_torque:
            varWrite("arm_pose",global.torque_pose)
            varWrite("active_weapon_prescaler",global.torque_scale)
        break
        
        case spr_shotgun:
            varWrite("arm_pose",global.shotgun_pose)
            varWrite("active_weapon_prescaler",global.shotgun_scale)
        break
        
        case spr_frag:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.nade_scale)
        break
        
        case spr_flame:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.flame_scale)
        break
        
        case spr_snare:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.snare_scale)
        break
        
        case spr_smoke:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.nade_scale)
        break
        
        case spr_flashbang:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.nade_scale)
        break
        
        case spr_ink:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.nade_scale)
        break
        
        case spr_sticky:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.nade_scale)
        break
        
        case spr_longshot:
            varWrite("arm_pose",global.longshot_pose)
            varWrite("active_weapon_prescaler",global.longshot_scale)
        break
    
        case spr_smg:
            varWrite("arm_pose",global.smg_pose)
            varWrite("active_weapon_prescaler",global.smg_scale)
        break
        
        case spr_lmg:
            varWrite("arm_pose",global.lmg_pose)
            varWrite("active_weapon_prescaler",global.lmg_scale)
        break

        case spr_vulcan:
            varWrite("arm_pose",global.vulcan_pose)
            varWrite("active_weapon_prescaler",global.vulcan_scale)
        break    
        
        case spr_boom:
            varWrite("arm_pose",global.boom_pose)
            varWrite("active_weapon_prescaler",global.boom_scale)
        break
        
        case spr_rocket:
            varWrite("arm_pose",global.rocket_pose)
            varWrite("active_weapon_prescaler",global.rocket_scale)
        break  
        
        case spr_double:
            varWrite("arm_pose",global.double_pose)
            varWrite("active_weapon_prescaler",global.double_scale)
        break  
        
        case spr_stomper:
            varWrite("arm_pose",global.stomper_pose)
            varWrite("active_weapon_prescaler",global.stomper_scale)
        break  
        
        case spr_boltok:
            varWrite("arm_pose",global.boltok_pose)
            varWrite("active_weapon_prescaler",global.boltok_scale)
        break   
        
        case spr_tickler:
            varWrite("arm_pose",global.tickler_pose)
            varWrite("active_weapon_prescaler",global.tickler_scale)
        break 
        
        case spr_thumper:
            varWrite("arm_pose",global.thumper_pose)
            varWrite("active_weapon_prescaler",global.thumper_scale)
        break 
        
        case spr_carbine:
            varWrite("arm_pose",global.carbine_pose)
            varWrite("active_weapon_prescaler",global.carbine_scale)
        break 
    }
}


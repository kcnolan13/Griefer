/// @description view zooming
if room_counter < 30*15 and nth_frame(10) and instance_exists(local_player)
{
    objVarWrite(local_player,"bot",bot_override)  
    //printf("ERROR (not): writing local_player.bot to "+string(bot_override))
}

if view_adjust_delay
    view_adjust_delay --


do_zoom = false
draw_killed_by = false

//match starting or ending
if match_starting() or match_ending() and not instance_exists(modal_controls) and not view_adjust_delay
{
    do_zoom = true
    view_lerp_real = 0.06
    view_xtarget = room_width/2
    view_ytarget = room_height/2
    
    if room_counter < 7.5*30
    {
        view_overscaler = 1.65
        
        if room_counter + 1 >= 7.5*30 and snapshot_mode and snapshot_auto
        {
            printf("::: triggering snapshot")
            event_perform(ev_keypress,vk_f9)
        }
    }
    else
    { 
        if instance_exists(local_player) and objVarRead(local_player,"visible") and objVarRead(local_player,"alive")
        {
            view_xtarget = lerp_real(__view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )/2,local_player.x,view_lerp_real) //objVarRead(local_player,"myX")
            view_ytarget = lerp_real(__view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )/2,local_player.y,view_lerp_real) //objVarRead(local_player,"myY")
            //printf("targeting local_player: "+objVarRead(local_player,"pName")+": @ ("+view_xtarget+", "+view_ytarget+")")
        }
        else
        {
            view_xtarget = lerp_real(__view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )/2,room_width/2,view_lerp_real)
            view_ytarget = lerp_real(__view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )/2,room_height/2,view_lerp_real)
        }
        
        if room_counter < 10.5*30 and instance_exists(local_player) and objVarRead(local_player,"visible")
        {
            view_overscaler = 0.55
        }
        else
        {
            if match_ending()
                view_overscaler = 1.15
            else
                view_overscaler = 1
        }
    }
}
//local player is bot
else if (instance_exists(local_player) and is_bot(local_player)) and not view_adjust_delay
{
    do_zoom = true
    if bot_focus_counter
        bot_focus_counter -= real_speed(1)
        
    if bot_focus_counter < 1
        bot_focus_counter = 0
        
    view_lerp_real = 0.06
    
    if bot_focus_counter and instance_exists(bot_focus)
    {
        view_overscaler = 0.85
        view_xtarget = lerp_real(__view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )/2,bot_focus.x,view_lerp_real)
        view_ytarget = lerp_real(__view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )/2,bot_focus.y,view_lerp_real)
        if not objVarRead(bot_focus,"alive")
        {
            bot_focus_counter = 0
        }
    }
    else
    {
        view_overscaler = 2
        view_xtarget = lerp_real(__view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )/2,room_width/2,view_lerp_real)
        view_ytarget = lerp_real(__view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )/2,room_height/2,view_lerp_real)
        if random(1) < 1/(2*30)
        {
            var target_ind = floor(random_range(0,instance_number(player)+0.99))
            bot_focus = instance_find(player,target_ind)
            
            if not instance_exists(bot_focus)
                bot_focus = noone
            else
            {
                printf("ERROR (not): focusing on new bot")
                bot_focus_counter = random_range(4*30,6*30)
            }
        }
    }
}
//YOU HAVE BEEN KILLED
else if instance_exists(local_player) and not objVarRead(local_player,"alive") and instance_exists(rag_target) and not view_adjust_delay
{
    draw_killed_by = true
    do_zoom = true
    view_lerp_real = 0.25
    view_overscaler = lerp_real(view_overscaler,view_overscaler_target,0.05)
    view_xtarget = lerp_real(__view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )/2,rag_target.x,view_lerp_real)
    view_ytarget = lerp_real(__view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )/2,rag_target.y,view_lerp_real)
}

//view zooming
if do_zoom and not view_adjust_delay
{
    view_hwidth = 1365*view_overscaler*VIEW_SCALE
    
    if view_hwidth > room_width
        view_hwidth = room_width
        
    view_vwidth = (9/16)*view_hwidth
    
    if view_vwidth > room_height
    {
        view_vwidth = room_height
        view_hwidth = 16/9*view_vwidth
    }
    
    __view_set( e__VW.WView, 0, ceil(lerp_real(__view_get( e__VW.WView, 0 ),view_hwidth,view_lerp_real )))
    __view_set( e__VW.HView, 0, ceil(lerp_real(__view_get( e__VW.HView, 0 ),view_vwidth,view_lerp_real )))
    
    if instance_exists(modal_controls) and in_match()
    {
        __view_set( e__VW.WView, 0, 1365 )
        __view_set( e__VW.HView, 0, 9/16*1365 )
    }
    
    __view_set( e__VW.XView, 0, view_xtarget - __view_get( e__VW.WView, 0 )/2 )//lerp_real(view_xview, view_xtarget - view_wview/2,view_lerp_real)
    __view_set( e__VW.YView, 0, view_ytarget - __view_get( e__VW.HView, 0 )/2 )//lerp_real(view_xview, view_ytarget - view_hview/2,view_lerp_real)
    
    keep_view_in_bounds()
}

    


///fill with random gear if you want
if keyboard_check(vk_control) and keyboard_check(vk_alt) and keyboard_check(vk_backspace)
{
   fill_with_random_gear()
}

if keyboard_check(vk_control) and keyboard_check(vk_alt) and keyboard_check(vk_end)
{
   delete_invisible_gear()
}


///switch home / central servers
if keyboard_check(vk_control) and keyboard_check(vk_alt) and keyboard_check(vk_home) and keyboard_check(vk_end)
{
   ini_open(grieferURL+"/Config/Config.ini")
   var savedURL = ini_read_string("Main","ServerURL",azureURL)
   
   if savedURL != azureURL
    ini_write_string("Main","ServerURL",azureURL)
   else
    ini_write_string("Main","ServerURL",homeURL)
    
   ini_close()
   
   launchGame(launcherURL+"/Downloads/Griefer.exe")
   game_end()
}


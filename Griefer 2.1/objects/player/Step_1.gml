/// @description perform step
if perform_step != 0
    exit

///RESPAWN HANDLER

if net_manager.local_player = id and alive_counter < 30 and not pressing_left() and not pressing_right() and not rolling and not jumping and not crawling
    animation_stand()

if is_bot(id) and SUPER_DEBUG
{
    printf("::: "+playerName(id)+" is a BOT! respawning in: "+string(respawn_counter))
}   

if respawn_counter > 0 and (is_my_avatar(id) or is_bot(id))
{
    if is_bot(id) and DEBUG printf("bot respawn counting down")
    
    respawn_counter = sub_real(respawn_counter, 1)
    
    if not respawn_counter
    {
        
        printf("::: Respawning Player "+playerName(id))
        
        //FIGURE OUT WHERE TO RESPAWN
        compute_respawn_coordinates(id, respawn_flag)   //computes spawn_x, spawn_y
        
        double_spawn_counter = double_spawn_window
        
        objVarWrite(id,"alive",true)
        respawn_flag = FL_NORMAL    //set afterwards on purpose
        
        if net_manager.local_player = id
            net_manager.rag_target = NO_HANDLE
        
        objVarWrite(id,"myX",spawn_x)
        objVarWrite(id,"myY",spawn_y)
        objVarWrite(id,"hp",100)
        objVarWrite(id,"alive",true)
        varWrite("speed_multiplier",1)
        varWrite("assister","")
        varWrite("killer","")
        varWrite("animation_speed",0)
        varWrite("fire_counter",0)
        obj_update_real(id,"fire_counter",FL_NORMAL)
        obj_update_string(id,"killer",FL_NORMAL)
        obj_update_string(id,"assister",FL_NORMAL)
        
        //make sure everybody else knows about where he's spawning
        obj_update_real(id,"myX",FL_NORMAL)
        obj_update_real(id,"myY",FL_NORMAL)
        
        hsp = 0
        vsp = 0
        rolling = 0
        crawling = 0
        animation_stand()
        varWrite("animation_speed",SPD_STAND)
        
        if net_manager.starting_match
        {
            x = objVarRead(id,"myX")
            y = objVarRead(id,"myY")
            
            with (id) 
            {
                scr_unstick_guy()
            }
            
            x = objVarRead(id,"myX")
            y = objVarRead(id,"myY")
            
        } else {
            //spawn his weapons
            spawn_my_weapons()
        }
        
        //send twice because it's hella important
        obj_update_real(id,"hp",FL_NORMAL)
        obj_update_real(id,"hp",FL_NORMAL)
        animation_stand()
    }

}

///spawning counters

if double_spawn_counter and (is_my_avatar(id) or is_bot(id))
{
    double_spawn_counter = sub_real(double_spawn_counter,1)
    
    if not double_spawn_counter
    {
        varWrite("visible",true)
        varWrite("controllable",true)
        obj_update_real(id,"alive",FL_NORMAL)
    }
    
    if is_my_avatar(id)    
        net_manager.hide_spawn_text = false
        
    var redo_spawn = false
        
    var overlapping_player = collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,player,true,true)
    if instance_exists(overlapping_player) and not is_local_teammate(overlapping_player) and varRead("myX") > 0 and varRead("myY") > 0
    {
        redo_spawn = true
        printf("::: Overlapping Players! Another spawn computation is in order ... ")
    }
    
    var min_los = min_line_of_sight_to_enemy(id)
    if  min_los < 64*8 and min_los > -1
    {
        printf("::: BAD SPAWN POINT! Min line of sight to enemy was: "+string(min_los))
        redo_spawn = true
    }
    
    if redo_spawn
    {
        double_spawn_counter = 0
        
        if is_my_avatar(id)
            net_manager.hide_spawn_text = true
        
        //another.id respawn coordinate computation is needed --> allow a little delay time to be safe(?)
        respawn_counter = floor(random_range(1,15))
        
        //sometimes randomize the spawn selection ... just to get out of a weird loop scenario (?)
        if random(1) < 0.25
            respawn_flag = FL_RANDOM
        
        printf("::: redoing spawn with FL_RANDOM in "+string(respawn_counter))
    }
        
}

//trigger another.id spawn if we've got overlapping guys
if not respawn_counter and match_starting()
{
    if collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,player,true,true) and varRead("myX") > 0 and varRead("myY") > 0
    {
        printf("::: Overlapping Players! Another spawn computation is in order ... ")
        //another.id respawn coordinate computation is needed --> allow a little delay time to be safe
        respawn_counter = floor(random_range(1,30))
    }
}

///handle view shaking
if not varRead("controllable") or is_bot(id) exit

view_shake_long /= 1.15
view_shake_medium /= 1.4
view_shake_short /= 2

view_shake = view_shake_long + view_shake_medium + view_shake_short

if abs(view_shake) < 0.3
view_shake = 0

if view_shake > 15 view_shake = 15

//view_angle[0] = random_range(-1*view_shake,view_shake)
view_xoff = floor(random_range(-3*view_shake,3*view_shake))
view_yoff = floor(random_range(-3*view_shake,3*view_shake))

if view_xoff or view_yoff
{
    //printf("::: doing some view shake: "+string(view_xoff)+", "+string(view_yoff))
}

__view_set( e__VW.XView, 0, __view_get( e__VW.XView, 0 ) + (view_xoff) )
__view_set( e__VW.YView, 0, __view_get( e__VW.YView, 0 ) + (view_yoff) )

///sync position
if not varRead("trigger_update_ignore")
{
    x = varRead("myX")
    y = varRead("myY")
}

///cursor offset computation

if not is_bot(id)
{
    if not global.using_gamepad //or  global.using_gamepad 
    {
        cursor.x = mouse_x
        cursor.y = mouse_y
    }
    else
    {
        if (gamepad_axis_check(global.devno,gp_axisrh) or gamepad_axis_check(global.devno,gp_axisrv))
        {
            if varRead("alive")
            {
                var ang_lerp_real = 1
                
                var addx = floor(global.cvals[C_LOOK_SENS]*gamepad_stick_val(gp_axisrh))
                var addy = floor(global.cvals[C_LOOK_SENS]*gamepad_stick_val(gp_axisrv))
                var ang = point_direction(x,y,cursor.x+addx,cursor.y+addy)
                
                if point_distance(x,y,cursor.x+addx,cursor.y+addy) < (global.cursor_offset)
                {
                    curs_xoff = floor(curs_xoff+addx)
                    curs_yoff = floor(curs_yoff+addy)
                }
                else
                {
                    var new_ang = lerp_real(global.cursor_dir,ang,ang_lerp_real)
                    curs_xoff = floor(trigx(global.cursor_offset,new_ang))
                    curs_yoff = floor(trigy(global.cursor_offset,new_ang))
                }
            }
            global.cursor_dir = floor(point_direction(x,y,cursor.x,cursor.y))
        }
        
        var tx = floor(x+curs_xoff)
        var ty = floor(y+curs_yoff)
            
        cursor.x = x+curs_xoff//mouse_x+256
        cursor.y = y+curs_yoff//mouse_y+256
    }
}

///view stuff

computed_curs = false
computed_view = false

if global.using_gamepad //or not computed_curs
compute_cursor_offset()

if global.using_gamepad or not computed_view
framely_view_adjust()


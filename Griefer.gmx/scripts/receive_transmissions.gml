//process general messages
wait_counter = 0
//printf("receiving transmissions")

while (bigMessagesWaiting() and wait_counter < 500000)
{
    net_manager.receptions++
    wait_counter++
    
    bigMessage = readBigMessage()
    
    if (isString("bigMessage1"))
        genVal1 = readBigValStr(1)
    else
        genVal1 = readBigValReal(1)
        
    if (isString("bigMessage2"))
        genVal2 = readBigValStr(2)
    else
        genVal2 = readBigValReal(2)
        
    if (isString("bigMessage3"))
        genVal3 = readBigValStr(3)
    else
        genVal3 = readBigValReal(3)
        
    switch (bigMessage)
    {
        case "control_map":
            printf("::: RECEIVED a Control Mapping")
            
            if genVal3 = 0
            {
                global.mydefaults[real(genVal1)] = real(genVal2)
                
                //overwrite local controls with incoming keyboard controls
                if not global.using_gamepad
                    global.cvals[real(genVal1)] = real(genVal2)
            }
            else
            {
                //printf("::: genVal3 = "+string(genVal3)+", map_const = "+string(genVal2))
                global.mygpdefaults[real(genVal1)] = real(genVal2)
                
                //overwrite local controls with incoming gamepad controls
                if global.using_gamepad
                    global.cvals[real(genVal1)] = real(genVal2)
            }
        break
        
        case "personal_stat":
            var player_name = string(genVal1)
            var stat_name = string(genVal2)
            var stat_val = genVal3
            printf("::: RECEIVED Personal Stat: "+string(player_name)+" -- "+string(stat_name)+" = "+string(stat_val))
            //write directly to stat_manager
            objVarWrite(stat_manager,stat_name,stat_val)
        break
        
        case "global_stat":
            var player_name = string(genVal1)
            var stat_name = string(genVal2)
            var stat_val = genVal3
            printf("::: RECEIVED Global Stat: "+string(player_name)+" -- "+string(stat_name)+" = "+string(stat_val))
            insert_global_stat(player_name,stat_name,stat_val)
        break
        
        case "leaderboard_dimensions":
            var rows = real(genVal1)
            var cols = real(genVal2)
            printf("::: RECEIVED leaderboard dimensions: "+string(rows)+" X "+string(cols))
            if instance_exists(modal_table)
            {
                modal_table.rows = rows //to make room for the header
                modal_table.cols = cols//+1 //because player + rank are split in grid
                with modal_table
                    event_perform(ev_step,ev_step_normal)
            }
            else
            {
                printf("ERROR: cannot set leaderboard dims ... modal_table does not exist")
            }
        break
    }
        
}

wait_counter = 0

while (genMessagesWaiting() and wait_counter < 500000)
{
    net_manager.receptions++
    
    wait_counter++
    genMessage = readGenMessage()
    if (isString("genMessage"))
        genVal = readGenValStr()
    else
        genVal = readGenValReal()
        
        //printf(genMessage+": "+genVal)
        
    switch (genMessage)
    {
        case "ack":
            net_manager.packets_received++
        break
        
        case "goto_map":
            //temp = "rm_map"+string(genVal)
            room_goto(map_placeholder1+1+genVal)
            if DEBUG
                printf("going to map: map_placeholder1 + "+genVal)
            return 0
        break
        
        case "perma_challenge":
            var cha = find_challenge(genVal)
            if instance_exists(cha)
            {
                cha.completed = true
                cha.shown_completed = true
                cha.tripped_end_match = true
            }
        break
        
        case "lock_armory":
            lock_armory = true
            with (bn_play) 
                event_perform(ev_mouse,ev_left_press)
        break
        
        case "goto_lobby":
            room_goto(rm_lobby)
            if DEBUG
                printf("received GOTO LOBBY!!")
            return 0
        break
        
        case "force_sync_doll":
            printf("FORCE-SYNCING DOLL")
            with net_manager sync_my_doll()
        break
        
        case "disconnect":
            printf("RECEIVED SERVER DISCONNECT")
            net_manager.server_found = false
            //griefer_restart()
        break
        
        case "player_quit":
            /*if not delete_avatar_by_name(genVal)
            {
                printf("ERROR: player quit and failed to destroy his avatar")
            }*/
            
            if (in_match() or (room = rm_lobby)) and instance_number(avatar) <= 2
            {
                printf("MISSION ABORT! MISSION ABORT!")
                abort_match()
            } else if (in_match() or (room = rm_lobby)) and genVal != varRead("pName")
            {
                printf("PLAYER QUIT: "+genVal)
                his_av = find_pname_avatar(genVal)
                if instance_exists(his_av)
                {
                    objVarWrite(his_av,"player_quit",true)
                    if in_match()
                    with his_av instance_destroy()
                }
                his_playa = find_player_by_pname(genVal)
                if instance_exists(his_playa)
                objVarWrite(his_playa,"player_quit",true)
            }
        break
        
        case "authentication_result":
            
            with processing instance_destroy()
            
            if genVal != FL_MULTIPLE
            {
                if (genVal = true)
                {
                    audio_play_sound(snd_click,2,false)
                    logIn(objVarRead(net_manager,"pName"))
                    printf("GOOD LOGIN")
                    room_goto(rm_menu)
                    return 0
                } else {
                    audio_play_sound(snd_denied,2,false)
                    bn_login_user.alert = "BAD Username/Password"
                    bn_login_user.alert_alpha = 1.5
                    printf("WRONG USERNAME / PASSWORD")
                }
            }
            else
            {
                audio_play_sound(snd_denied,2,false)
                bn_login_user.alert = "Logged In Somewhere Else"
                bn_login_user.alert_alpha = 1.5
                printf("MULTIPLE LOGINS DETECTED")
            }
        break
        
        case "user_create_result":
            if (genVal = true)
            {
                logIn(objVarRead(net_manager,"pName"))
                if DEBUG
                    printf("going to menu")
                room_goto(rm_menu)
                return 0
            } else {
                if DEBUG
                    printf("USER ALREADY EXISTS")
                with (processing) instance_destroy()
            }
        break
        
        case "end_match":
            if room != rm_lobby
                room_goto(rm_lobby)
            //if DEBUG
                printf("received END MATCH!!")
        break
    }
}
//printf("done genMessages")
//process object creates
wait_counter = 0
while (objCreatesWaiting() and wait_counter < 50)
{
    net_manager.receptions++
    
    wait_counter++
    obj_index = readObjCreateIndex()
    unique_id = readObjCreateUniqueId()
    my_x = readObjCreateMyX()
    my_y = readObjCreateMyY()
    
    //ID = instance_create(room_width/2,room_height/2,input_field)
    if DEBUG
        printf("create: "+obj_index+", id="+unique_id+", "+my_x+", "+my_y)
    //if room != rm_match_end
    {
        ID = instance_create(my_x, my_y, obj_index)
        objVarWrite(ID,"myX",my_x)
        objVarWrite(ID,"myY",my_y)

        ID.loc = false
        
        //printf("create obj: "+ID.id+", at "+ID.x+", "+ID.y+" ---> uniqueId: "+unique_id);
        objVarWrite(ID,"uniqueId",unique_id)
        if SUPER_DEBUG
            printf("created (object "+ID.object_index+") with uniqueId "+objVarRead(ID,"uniqueId"))
    }
}
//printf("done objCreates")
//process object updates
wait_counter = 0
push_count = 0
while (objUpdatesWaiting() and wait_counter < 1000)
{
    net_manager.receptions++
    
    wait_counter++
    //obj_index = readObjUpdateIndex()
    //unique_id = readObjUpdateUniqueId()
    //printf("obj update! reading oid_str")
    printf("{O}: reading objUpdate oid string")
    oid_str = readObjUpdateOidStr()
    obj_index = extract_object_index(oid_str)
    unique_id = extract_uid(oid_str)
    
    printf("{O}: reading objUpdate netvar")
    netvar = readObjUpdateNetvar()
    
    strVal = false
    
    if (isString("objUpdate"))
    {
        printf("{O}: reading objUpdate string val")
        val = readObjUpdateValStr()
        strVal = true
        printf("payload is str: "+string(val))
    }
    else
    {
        printf("{O}: reading objUpdate real val")
        val = readObjUpdateValReal()
        printf("payload is real: "+string(val))
    }
    
    printf("obj_update for "+oid_str+" ( "+string(obj_index)+" : "+string(unique_id)+" ) ... "+string(netvar)+" = "+string(val))
    
    printf("{O}: reading objUpdate flag")
    flag = readObjUpdateFlag()
    
    //printf("flag is: "+flag)
    
    ID = find_obj_with_id(obj_index,unique_id)
    
    if netvar = "winning_pName"
                printf("ERROR (not): caught winning_pName: "+string(val))
    
    //push back objects that don't exist yet
    if ID  = NO_HANDLE
    {
        if /*room != rm_match_end and */push_count < 10
        {
            push_count++
            
            /*if push_count = 100
            {
                printf("BAD CONNECTION DETECTED")
                printf("MISSION ABORT! MISSION ABORT!")
                griefer_restart()
            }*/
            if DEBUG
                printf("PUSH BACK: update: "+string(obj_index)+", id="+unique_id+", "+netvar+", "+val)
           
             if (strVal)
                objPushBackString(obj_index,unique_id,netvar,val,flag)
            else
                objPushBackReal(obj_index,unique_id,netvar,val,flag)
        }
        
        //next loop iteration
        continue
    }
    
    //update objects that do exist
    switch (flag)
    {
        case FL_DECREMENT:
            objVarWrite(ID,netvar,typeconscious_sub(objVarRead(ID,netvar),val))
        break
        
        case FL_INCREMENT:
            objVarWrite(ID,netvar,typeconscious_add(objVarRead(ID,netvar),val))
        break
        
        case FL_INSTANCE_DESTROY:
            if DEBUG
                printf("DESTROYING (object "+ID.object_index+") with uniqueId "+objVarRead(ID,"uniqueId")+". Remote kill signal.")
            with (ID) 
            {
                instance_destroy()
                exit
            }
        break
        
        default:
        
            if netvar = "pName"
                printf("update pName = "+string(val)+" for uniqueId #"+string(objVarRead(ID,"uniqueId")))
                
            if netvar = "winning_pName"
                printf("ERROR (not): caught winning_pName: "+string(val))
                
            if (netvar="global_rank" or netvar="rank" or netvar="uniqueId") and ((is_my_avatar(ID) and ID.object_index != player) or ID.object_index = net_manager)
            {
                //if ID.object_index != net_manager //and ID != net_manager.my_doll
               // objVarWrite(ID,netvar,val)
                
                printf("CAUGHT GLOBAL STAT: "+netvar)
                //mega_stat_update(netvar,val)
                update_global_stat(ID,netvar,val)
            }
            else objVarWrite(ID,netvar,val)
            
        break
    
    }
    
    //if (obj_index != 1)
    //if /*SUPER_DEBUG and */((obj_index != 1) or (obj_index = 1 and obj_index.debug_counter < 3*room_speed))
        printf("{O}: PROCESSED UPDATE : "+string(obj_index)+"[uId "+string(unique_id)+"] -> " +string(netvar)+" = "+string(objVarRead(ID,netvar)))
}
//printf("done objUpdates")

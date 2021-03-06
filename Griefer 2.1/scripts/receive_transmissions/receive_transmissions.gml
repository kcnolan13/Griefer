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
        case "new_user":
            printf("::: tutorial time!")
            net_manager.new_user = true
            ui_new_user()
        break
        
        case "control_map":
            printf("::: Received a Control Mapping")
            
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
        
        case "load_setting":
            printf("::: Received a Setting: "+string(genVal1)+", "+string(genVal2)+", "+string(genVal3))
            var ind = gc_ind(genVal1)
            if ind > -1
            {
                if global.gc[ind,2] // if it is_sens use real val
                    global.gc[ind,1] = genVal3
                else
                    global.gc[ind,1] = genVal2
            }
            else
            {
                printf("ERROR: failed to process load_setting big_message from server")
            }
        break
        
        case "accolade":
            var dat_acc_name = string(genVal1)
            var acc_val = genVal2
            var stat_fl = genVal3
            
            printf("::: Received Accolade: "+string(dat_acc_name)+" = "+string(acc_val))
            update_accolade_total(string(dat_acc_name),acc_val,stat_fl,false)
        break
        
        case "personal_stat":
            var player_name = string(genVal1)
            var stat_name = string(genVal2)
            var stat_val = genVal3
            printf("::: Received Personal Stat: "+string(player_name)+" -- "+string(stat_name)+" = "+string(stat_val))
            if not objVarRead(stat_manager,stat_name+"_valid")
            {
                objVarWrite(stat_manager,stat_name+"_valid",true)
            }
            //write directly to stat_manager
            objVarWrite(stat_manager,stat_name,stat_val)
        break
        
        case "global_stat":
            var player_name = string(genVal1)
            var stat_name = string(genVal2)
            var stat_val = genVal3
            //printf("::: Received Global Stat: "+string(player_name)+" -- "+string(stat_name)+" = "+string(stat_val))
            insert_global_stat(player_name,stat_name,stat_val)
        break
        
        case "leaderboard_page":
            row_offset = real(genVal1)
            force_page = real(genVal2)
            high_row = real(genVal3)
            
            printf("::: LEADERBOARD PAGE INFO RECEIVED")
            printf("::: row_offset = "+string(row_offset)+", force_pag = "+string(force_page)+", high_row = "+string(high_row))
            
            with (modal_table)
            {
                s_index = 0
                varWrite("row_offset",other.row_offset)
                varWrite("force_page",other.force_page)
                varWrite("force_row",max(0,other.high_row-other.row_offset-5))
                high_row = other.high_row-other.row_offset
            }
        
        break
        
        
        case "leaderboard_dimensions":
            rows = real(genVal1)
            cols = real(genVal2)
            page_max = real(genVal3)
            
            printf("::: Received leaderboard dimensions: "+string(rows)+" X "+string(cols)+", with "+string(page_max)+" total pages")
            
            with modal_table
            {
                rows = other.rows //to make room for the header
                cols = other.cols//+1 //because player + rank are split in grid
                page_max = other.page_max
                event_perform(ev_step,ev_step_normal)
            }
            
            if not instance_exists(modal_table)
            {
                printf("ERROR: cannot set leaderboard dims ... modal_table does not exist")
            }
        break
        
        case "kill_feed":
            printf("::: Received kill feed message!")
            new_kill_feed_message(genVal1,genVal2,genVal3)
        break
        
        case "chat_feed":
            printf("::: Received chat feed message!")
            new_chat_feed_message(genVal1,genVal2,genVal3)
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
        
        case "validate_hash":
            if genVal != 1
            {
                download_updates()
            }
        break   
        
        case "special_ping":
            popup_alert(WVIEW/2,HVIEW/2,"Special Ping",string(genVal))
            
        break
        
        case "done_loading":
            if global.load_count > 0 global.load_count --
            else global.load_count = 0
            
            printf("::: Done Loading! global.load_count --> "+string(global.load_count))
            
            if not global.load_count
            {
                with modal_dialogue
                {
                    if is_loading and not is_downloading
                    {
                        fade_delay = 5
                    }
                }
            }
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
            
            if instance_exists(bn_play_tab)
                bn_play_tab.active = true
                
            net_manager.menu_mode = "lobby"
            varWrite("lobby_wait_time",lobby_match_countdown_time)
            
            with stat_manager
            {
                if instance_exists(net_manager.stat_gravatar)
                {
                    objVarWrite(net_manager.stat_gravatar,"pName",playerName(myAvatar()))
                    grav_name = playerName(myAvatar())
                    request_personal_stats(playerName(myAvatar()),stat_flag)
                } else printf("ERROR: stat_manager on received lock armory cannot find net_manager.stat_gravatar")
            }
            
        break
        
        case "goto_lobby":
            room_goto(rm_lobby)
            if DEBUG
                printf("Received GOTO LOBBY!!")
            return 0
        break
        
        case "force_sync_doll":
            printf(":::FORCE-SYNCING DOLL")
            with net_manager sync_my_doll()
        break
        
        case "disconnect":
            printf(":::RECEIVED SERVER DISCONNECT")
            net_manager.server_found = false
            //griefer_restart()
        break
        
        case "player_quit":
        
            possible_shuffle = false
            
            //be 100% sure the player name is a string
            genVal = string(genVal)
            
            if instance_number(avatar) <= 2
            {
                if in_match()
                {
                    net_manager.match_collapsed = true
                }
                else
                {
                    printf(":::MISSION ABORT! MISSION ABORT!")
                    abort_match()
                }
            }
            
            if (in_match() or (room = rm_lobby)) and genVal != varRead("pName")
            {
                printf(":::PLAYER QUIT: "+genVal)
                his_av = find_pname_avatar(genVal)
                if instance_exists(his_av)
                {
                    objVarWrite(his_av,"player_quit",true)
                    
                    if not in_match()
                    {
                        if objVarRead(his_av,"pNum") = 0
                            possible_shuffle = true
                    }
               
                    printf("::: destroying avatar who quit: "+string(playerName(his_av)))
                    with his_av instance_destroy()
                }
                else
                {
                    printf("ERROR: unable to find avatar obj for player who quit: "+genVal)
                }
                
                compute_lowest_pnum()
                
                if in_match()
                {
                    net_manager.collapsed_numplayers ++
                    his_playa = find_player_by_pname(genVal)
                    if instance_exists(his_playa)
                    {
                        objVarWrite(his_playa,"player_quit",true)
                        objVarWrite(his_playa,"pNum",-1)
                        his_playa.x = -500
                        his_playa.y = -500
                        //objVarWrite(his_playa,"controllable",false)
                        objVarWrite(his_playa,"visible",false)
                        his_playa.visible = false
                        printf("::: pacifying player who quit: "+string(playerName(his_playa)))
                    }
                    else
                    {
                        printf("ERROR: unable to find player obj for player who quit: "+genVal)
                    }
                
                    validate_score_grids()
                
                    if instance_exists(his_playa)
                    {
                        popup_alert(WVIEW/2+global.xoff,64*2.5,"Rage Quitter",capwords(genVal)+" has Rage Quit and Will Be Penalized.")
                    }
                    else
                    {
                        with popup_alert(WVIEW/2+global.xoff,64*2.5,"Network Error",capwords(genVal)+" has Rage Quit, but has not been penalized due to a network error.")
                            critical = true
                    }
                    
                    //PENALIZE!!
                    if lobby_leader()
                    {
                        if instance_exists(his_playa)
                        {
                            player_quit_stat_updates(his_playa)
                        }
                    }
                }
                else
                {
                    //possibly shuffle pnum's around
                    if possible_shuffle
                    { 
                        printf("::: possible shuffle needed here")
                        if instance_exists(myAvatar()) and objVarRead(myAvatar(),"pNum") = global.lowest_pnum
                        {
                            printf("::: asking for pNum shuffle: player 0 quit while in lobby")
                            sendMessageReal("shuffle_pnums",true)   
                        }
                    }
                }
            }
        break
        
        case "authentication_result":
            
            with processing instance_destroy()
            
            if genVal != FL_MULTIPLE
            {
                if (genVal = 1)
                {
                    printf("::: GOOD LOGIN")
                    audio(snd_click,1)
                    net_manager.login_when_ready = true
                    with gravatar
                    {
                        varWrite("lerp_delay",login_lerp_delay/5*(5-varRead("pNum")))
                    }
                    with modal_window
                    {
                        if translation_x != 0 or object_index = modal_splat
                        {
                            if id = net_manager.uname or id = net_manager.pword or id = net_manager.play or id = net_manager.rand
                                fade_out = true
                            else
                                translation_xtarget = 0
                                
                            if object_index = modal_splat
                            {   
                                fade_out = false
                                fade_delay = ceil(random_range(1,15))
                                scale_lerp = 0.2
                            }
                        }
                    }
                }
                else if (genVal = 2)
                {
                    var nocaps = objVarRead(net_manager,"pName")
                    var new_name = string(capwords(objVarRead(net_manager,"pName")))
                    printf("::: ERROR: new_name = "+nocaps+" --> "+new_name)
                    with popup_yesno(WVIEW/2,HVIEW/2,"Create Player", "Create new player "+string(new_name)+"?\nPassword: "+string(net_manager.pword.text),scr_create_user,scr_none)
                    {
                        header_color = web_hsv(224,54,71)
                    }
                } 
                else {
                    audio(snd_denied,1)
                    with popup_alert(WVIEW/2+global.xoff,HVIEW/2,"User Exists / Wrong Password","That is not the correct password for "+string(capwords(objVarRead(net_manager,"pName")))+".")
                    {
                        header_color = web_hsv(0,100,85)
                        header_text_color = c_white
                    }
                }
            }
            else
            {
                audio(snd_denied,1)
                with popup_alert(WVIEW/2+global.xoff,HVIEW/2,"Already Logged In",string(capwords(objVarRead(net_manager,"pName")))+" is logged in somewhere else.")
                {
                    header_color = web_hsv(0,100,85)
                    header_text_color = c_white
                }
            }
        break
        
        case "user_create_result":
            if (genVal = true)
            {
                logIn(objVarRead(net_manager,"pName"))
                printf("::: USER CREATED ... going to menu")
                room_goto(rm_menu)
                return 0
            } else {
                printf("::: USER ALREADY EXISTS")
                with (processing) instance_destroy()
            }
        break
        
        case "end_match":
            if room != rm_lobby
                room_goto(rm_lobby)
            //if DEBUG
                printf("::: received END MATCH!!")
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
    printf("::: objCreate: "+string(unique_id)+": "+string(object_get_name(obj_index)))
    my_x = readObjCreateMyX()
    my_y = readObjCreateMyY()
    
    if obj_index = avatar
    {
        do_create = true
        create_unique_id = unique_id
        with avatar
        {
            if varRead("uniqueId") = other.create_unique_id
                other.do_create = false
        }
        if not do_create
        {
            printf(":::WARNING: bailing out of objCreate message --> avatar "+string(unique_id)+" already exists")
            continue
        }
    }
    
    //ID = instance_create(room_width/2,room_height/2,input_field)
    //if DEBUG
      //  printf("create: "+obj_index+", id="+unique_id+", "+my_x+", "+my_y)
    //if room != rm_match_end
    {
        ID = instance_create(my_x, my_y, obj_index)
        objVarWrite(ID,"myX",my_x)
        objVarWrite(ID,"myY",my_y)

        ID.loc = false
        
        //printf("create obj: "+ID.id+", at "+ID.x+", "+ID.y+" ---> uniqueId: "+unique_id);
        objVarWrite(ID,"uniqueId",unique_id)
        objVarWrite(ID,"pName",unique_id)
       // if SUPER_DEBUG
         //   printf("created (object "+ID.object_index+") with uniqueId "+objVarRead(ID,"uniqueId"))
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
    oid_str = readObjUpdateOidStr()
    obj_index = extract_object_index(oid_str)
    unique_id = extract_uid(oid_str)
    
   // printf("{O}: reading objUpdate netvar")
    netvar = readObjUpdateNetvar()
    
    strVal = false
    
    if (isString("objUpdate"))
    {
        //printf("{O}: reading objUpdate string val")
        val = readObjUpdateValStr()
        strVal = true
       // printf("payload is str: "+string(val))
    }
    else
    {
       // printf("{O}: reading objUpdate real val")
        val = readObjUpdateValReal()
       // printf("payload is real: "+string(val))
    }
        
    //printf("{O}: reading objUpdate flag")
    flag = readObjUpdateFlag()
    
    //printf("flag is: "+flag)
    
    ID = find_obj_with_id(obj_index,unique_id)
    
    if netvar = "winning_pName"
                printf("::: caught winning_pName: "+string(val))
    
    //push back objects that don't exist yet
    if ID  = NO_HANDLE
    {
        if push_count < 10
        {
            push_count++

            
            if DEBUG
                printf("::: PUSH BACK: update: "+string(obj_index)+", id="+string(unique_id)+", "+string(netvar)+", "+string(val))
           
             if (strVal)
                objPushBackString(obj_index,unique_id,netvar,val,flag)
            else
                objPushBackReal(obj_index,unique_id,netvar,val,flag)
        }
        
        //next loop iteration
        continue
    }
    
    if ID.object_index = gravatar and ID.bparts_done_ready
    {
        //bail on this update
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
            //if DEBUG
              //  printf("DESTROYING (object "+ID.object_index+") with uniqueId "+objVarRead(ID,"uniqueId")+". Remote kill signal.")
            with (ID) 
            {
                instance_destroy()
                exit
            }
        break
        
        default:
                
            if netvar = "winning_pName"
                printf("::: caught winning_pName: "+string(val))
                
            if (netvar="global_rank" or netvar="rank" or netvar="uniqueId") and ((is_my_avatar(ID) and ID.object_index != player) or ID.object_index = net_manager)
            {
                //if ID.object_index != net_manager //and ID != net_manager.my_doll
               // objVarWrite(ID,netvar,val)
                
                //printf("Caught Global Stat: "+netvar)
                //mega_stat_update(netvar,val)
                update_global_stat(ID,netvar,val)
            }
            else 
            {
                do_obj_update = true
                
                if netvar = "lobby_wait_time"
                {
                    printf("::: Important Update for "+string(ID.object_index)+" : "+string(netvar)+" = "+string(val))
                    
                    //DON'T DO THE UPDATE IF THE COUNTDOWN HAS STARTED OR IS ABOUT TO
                    if room = rm_lobby and val > lobby_match_countdown_time+30
                    {
                        with bn_ready
                        {
                            if sent_ready
                                other.do_obj_update = false
                        }
                    }
                }
                
                if do_obj_update and (ID.object_index != player or not (netvar = "net_hsp" or netvar = "net_vsp" or netvar = "myX" or netvar = "myY"))
                {
                    //PERFORM THE ACTUAL UPDATE
                    objVarWrite(ID,netvar,val)
                }
                
                if netvar = "pNum"
                {
                    var bound_av = find_pname_avatar(objVarRead(ID,"pName"))
                    if bound_av != noone
                    {
                        printf("::: updating bound av"+playerName(bound_av)+"'s pNum: "+string(objVarRead(bound_av,"pNum"))+" ---> "+string(val))
                        objVarWrite(bound_av,"pNum",val)
                    }
                    printf("::: PNUM UPDATE for "+string(objVarRead(ID,"pName"))+" : "+string(netvar)+" = "+string(val))
                    objVarWrite(ID,"pNum_override",val)
                    //ID.spam_pnum = 4
                    //with ID
                    //    printf("::: SPAM -- "+string(varRead("pName"))+"'s avatar has pNum="+string(varRead("pNum"))+", override="+string(varRead("pNum_override")))
                }
                else if netvar = "nextMapVote"
                {
                    recompute_votes()
                }else if ID.object_index = player and (netvar = "net_hsp" or netvar = "net_vsp" or netvar = "myX" or netvar = "myY")
                {
                    //SPECIAL UPDATE FOR PHYSICS VARS
                    objVarWrite(ID,"physics_updated",true)
                    objVarWrite(ID,netvar+"_true",val)
                    //printf("::: "+playerName(ID)+"'s physics were updated: "+string(netvar)+"_true = "+string(val))
                } else if netvar = "my_player"
                {
                    printf("::: received my_player = "+string(val)+" update for "+string(objVarRead(ID,"name")))
                }
            }
            
        break
    
    }
    
    //if (obj_index != 1)
    //if /*SUPER_DEBUG and */((obj_index != 1) or (obj_index = 1 and obj_index.debug_counter < 3*30))
       // printf("{O}: PROCESSED UPDATE : "+string(obj_index)+"[uId "+string(unique_id)+"] -> " +string(netvar)+" = "+string(objVarRead(ID,netvar)))
}
//printf("done objUpdates")

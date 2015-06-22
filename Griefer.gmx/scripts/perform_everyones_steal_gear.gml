///perform_everyones_steal_gear()

//if DEBUG
    printf("")
    printf("")
    printf("COMPUTING STOLEN GEAR")
    
varWrite("gearsteal_computed",true)
obj_sendval_real(id,"gearsteal_computed",true, FL_NORMAL)

/*

//dummy vars
winner = net_manager.winner

if not bot_match
{
    bigWinner = my_doll
}  
else
{
    if instance_exists(net_manager.winner)
        bigWinner = winner //winner was already computed for this one!!
    else
    {
        printf("")
        printf("BAILING OUT OF GEAR_STEAL --> MATCH IS A TIE")
        printf("")
        tied_bot_match = true
        return false
    }
    
}

//printf("WINNER IS: "+string(objVarRead(bigWinner,"pName")))

winners = ds_list_create()
losers = ds_list_create()
ds_list_clear(winners)
ds_list_clear(losers)

var large_loop = 0

while (winners = losers) and large_loop < 4000
{
    large_loop ++
    
    ds_list_destroy(winners)
    ds_list_destroy(losers)
    
    winners = ds_list_create()
    
    blah = ds_list_create()
    blah2 = ds_list_create()
    blah3 = ds_list_create()
    
    losers = ds_list_create()
    ds_list_clear(winners)
    ds_list_clear(losers)
    
    ds_list_destroy(blah)
    ds_list_destroy(blah2)
    ds_list_destroy(blah3)
    
    if large_loop > 100
        printf("ERROR: LARGE LOOP IN STEAL GEAR!!!")
}

//WINNERS are everyone on your team (this routine is only called by the guy with the match-ending kill)
for (var i=0; i<instance_number(avatar); i++)
{
    ID = instance_find(avatar,i)
    if ID = bigWinner or are_teammates(ID, bigWinner)
    {
        //this is a teammate --> thus, a guy who will be stealing gear
        printf("added "+objVarRead(ID,"pName")+" to winners")
        ds_list_add(winners,ID)
    }
    else 
    {
        printf("added "+objVarRead(ID,"pName")+" to losers")
        ds_list_add(losers,ID)
        //sync up this avatar with the limbs of his player --> just for reassurance
        sync_avatar_with_his_player(ID)
    }
}

var attempts = 0

//if DEBUG
    //printf("    #winners: "+ds_list_size(winners)+", #losers: "+ds_list_size(losers))

while (not ds_list_empty(losers) and not ds_list_empty(winners) and attempts < 40)
{
    attempts++
    
    //select a random loser and grab a piece of gear from him --> both the losers list and the winners list will diminish over time
    var loser_ind = floor(random_range(0,ds_list_size(losers)-0.1))
    var winner_ind = floor(random_range(0,ds_list_size(winners)-0.1))
    var loser = losers[| loser_ind]
    var winner = winners[| winner_ind]
    
    printf(objVarRead(loser,"pName")+": ")
    for (var i=0; i<8; i++)
    {
        printf(string(limb_type_from_list_index(i))+"0: "+string(objVarRead(loser,limb_type_from_list_index(i)))+"0")
    }
    
    gear_attempts = 0
    stole = false
    //try each of this loser's equipped pieces in random order
    while (gear_attempts < 32 and stole = false)
    {
        
        gear_attempts++
        gear_ind = floor(random_range(0,7.99))
        
        //if DEBUG
            //printf("        trying gear index"+gear_ind)

        //get the sprite to lookup
        var limb_str = limb_type_from_list_index(gear_ind)+"0"
        var spr_2steal = objVarRead(loser,limb_str)
        
        //printf("limb_str = "+limb_str)
        //printf("spr_2steal = "+spr_2steal)
        
        //was check if > 7 or < 17
        if is_sprite_none(spr_2steal)
        {
            spr_2steal -= 8
        }
        
        if DEBUG
            printf("          "+objVarRead(loser,"pName")+"'s "+limb_str+" is: "+"sprite_index "+string(spr_2steal)+" a.k.a. "+bpart_lookup(spr_2steal,global.BPART_NAME))
        
        //is this piece stealable?
        if bpart_lookup(spr_2steal,global.BPART_STEALABLE)
        {
            //KLEPTO DAT PIECE!!
            //if DEBUG
                printf("")
                //printf("          --- can steal. KLEPTO IN DIS BITCH!   "+string(spr_2steal)+"!")
                printf("")
            //update that player's actual network stats --> take the gear away
            //THIS SHOULDN'T WORK YET --- NO HANDLER ON SERVER SIDE
            //printf("telling "+objVarRead(loser,"pName")+"to LOSE sprite "+string(spr_2steal))
            objVarWrite(loser,"gear_to_lose",spr_2steal)
            objVarWrite(loser,"lost_gear_source",objVarRead(winner,"pName"))
            obj_update_real(loser,"gear_to_lose",FL_NORMAL)
            obj_update_string(loser,"lost_gear_source",FL_NORMAL)
            
            //adjust your bot rank if relevant
            if bot_match
            {
                if winner = net_manager.my_doll
                {
                    printf("")
                    //printf("PROMOTING BOT RANK TO: "+string(objVarRead(net_manager.my_doll,"bot_rank")+1))
                    objVarAdd(net_manager.my_doll,"bot_rank",1)
                    stat_update_real("bot_rank",objVarRead(net_manager.my_doll,"bot_rank"),FL_NORMAL)
                    syncVarFrom(net_manager.my_doll,"bot_rank")
                }
                else if loser = net_manager.my_doll
                {
                    printf("")
                    if objVarRead(net_manager.my_doll,"bot_rank") > 0
                    {
                       // printf("DEMOTING BOT RANK TO: "+string(objVarRead(net_manager.my_doll,"bot_rank")-1))
                        objVarSub(net_manager.my_doll,"bot_rank",1)
                        stat_update_real("bot_rank",objVarRead(net_manager.my_doll,"bot_rank"),FL_NORMAL)
                        syncVarFrom(net_manager.my_doll,"bot_rank")
                    }
                    else printf("    ....cannot demote bot rank past 0")
                }
            }
            
            if not bot_match
                pname_stat_update_string(objVarRead(loser,"pName"), limb_str, string(truncate(8+gear_ind,4))+"_"+string(global.src_disabled), FL_NORMAL)
            
            //if DEBUG
              //  printf("    "+objVarRead(winner,"pName")+" STEALING "+string(limb_str)+" FROM "+objVarRead(loser,"pName"))
            printf("")
            //send the trigger for this gear to go into the winner player's cache
            objVarWrite(winner,"gear_to_steal",spr_2steal)
            objVarWrite(winner,"stolen_gear_source",objVarRead(loser,"pName"))
            
            if not is_my_avatar(winner) and not bot_match
            {
                //if DEBUG
                   // printf("    SENDING stolen gear trigger to remote player: "+objVarRead(winner,"pName"))

                obj_update_real(winner,"gear_to_steal",FL_NORMAL)
                obj_update_string(winner,"stolen_gear_source",FL_NORMAL)
            }
            
            //remove the winner from the needs-to-steal-gear list
            ds_list_delete(winners,winner_ind)
            stole = true
        }
    }
    //no matter what, remove this player from the losers list (he either got gear stolen, or there is nothing to steal)
    ds_list_delete(losers,loser_ind)
}

//free up dynamically-allocated memory
ds_list_destroy(winners)
ds_list_destroy(losers)

*/
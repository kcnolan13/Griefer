/// @description go invisible if in a match
event_inherited()

visible = false
varWrite("visible",false)

if is_bot(id) and not in_match()
{
    shuffling = shuffling_max+shuffling_toff*(varRead("pNum")-1)
}

if in_match()
{
    varWrite("match_points",0)
    varWrite("points",0)
}
else
{
    alarm[0] = 30
}
    
if room = rm_menu
{
    //varWrite("uniqueId","-52")
    y = -64*5
    x = room_width*4/5
}

if room = rm_lobby and not net_manager.came_from_match and net_manager.my_doll != id and not is_bot(id)
{
    printf("DESTROYING WEIRD EXTRA AVATAR")
    instance_destroy()
}

///create his player on match start if he's a bot
if is_bot(id) and in_match()
{
    my_bot = instance_create(random(room_width), -4*room_height,player)
    syncVar(my_bot,"bot")
    syncVar(my_bot,"uniqueId")
    syncVar(my_bot,"pNum")
    syncVar(my_bot,"rank")
    syncVar(my_bot,"pName")
    syncVar(my_bot,"global_rank")
    
    my_bot.weapon_switch_delay_max /= 3*varRead("rank")/array_length_1d(global.rank_names)+1
    
    for (var i=0; i<9; i++)
    {
        syncVar(my_bot,global.bpart_limb_types[i]+"0")
    }
    
    printf(":::created bot player: "+string(objVarRead(my_bot,"pName"))+", pNum="+string(objVarRead(my_bot,"pNum")))
}

if is_bot(id) and room = rm_lobby
{
    //pick an appropriate rank based on the player's rank
    if not instance_exists(net_manager.my_doll)
        printf("MY_DOLL HAS DISAPPEARED AT START OF ROOM!")
        
    var cand_rank = objVarRead(net_manager.my_doll,"bot_rank")
    
    //pick a value within 1 of this rank
    /*cand_rank = floor(random_range(cand_rank-1,cand_rank+1.99))
    if cand_rank < 0 cand_rank = 0
    varWrite("rank",cand_rank)*/
}

/* */
///voting
if room = rm_lobby
{
    varWrite("nextMapVote",-1)
}

/* */
/*  */

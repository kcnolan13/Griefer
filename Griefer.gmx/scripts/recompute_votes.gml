///recompute_votes()
printf("::: recomputing votes")
with net_manager
{
    votes1 = 0
    votes2 = 0
    votes3 = 0
    
    //get totals
    with avatar
    {
        var vnum = varRead("nextMapVote")
        if vnum = objVarRead(net_manager,"next_map1")
            net_manager.votes1++
        else if vnum = objVarRead(net_manager,"next_map2")
            net_manager.votes2++
        else if vnum = objVarRead(net_manager,"next_map3")
            net_manager.votes3++
        else
        {
            printf("ERROR: "+varRead("pName")+"'s avatar has bad map vote num: "+string(vnum))
        }
    }
    
    //apply totals to bn_vote
    with bn_vote
    {
        if map_num = objVarRead(net_manager,"next_map1")
        {
            if net_manager.votes1 = 0 text = ""
            else text = string(net_manager.votes1)+" "+pluralize("Vote",net_manager.votes1)
        }
        else if map_num = objVarRead(net_manager,"next_map2") {
            if net_manager.votes2 = 0 text = ""
            else text = string(net_manager.votes2)+" "+pluralize("Vote",net_manager.votes2)
        }
        else if map_num = objVarRead(net_manager,"next_map3") {
            if net_manager.votes3 = 0 text = ""
            else text = string(net_manager.votes3)+" "+pluralize("Vote",net_manager.votes3)
        }
        else
        {
            printf("ERROR: bn_vote has bad map_num: "+string(map_num))
        }
    }

}

/// @description compute_lowest_pnum()
/// @function compute_lowest_pnum

if instance_exists(avatar)
{
    global.lowest_pnum = 999
    
    for (var i=0; i<instance_number(avatar); i++)
    {
        with instance_find(avatar,i)
        {
            var num = varRead("pNum")
            if num < global.lowest_pnum
                global.lowest_pnum = num
        }
    }
    printf("::: recomputed lowest pnum --> "+string(global.lowest_pnum))
    
    if net_manager.team > -1 and instance_exists(player)
    {
        global.lowest_pnum_team2 = 999
        
        for (var i=0; i<instance_number(player); i++)
        {
            with instance_find(player,i)
            {
                if get_team(id) = 1 and varRead("pNum") < global.lowest_pnum_team2 
                    global.lowest_pnum_team2 = varRead("pNum")
            }
        }
        
        printf("::: recomputed lowest_pnum_team2 --> "+string(global.lowest_pnum_team2))
    }
    
}
else
{
    printf("::: it is pointless computing lowest pnum and/or lowest pnum team2 when no avatars exist")
}

pNum = argument0
stat = argument1
val = argument2

if pNum = 0
{
    if (ds_map_exists(net_manager.p1Stats,stat))
    {
        ds_map_replace(net_manager.p1Stats,stat,val)
        return 1
    } else {
        ds_map_add(net_manager.p1Stats,stat,val)
        return 1
    }
} else if pNum = 1
{
    if (ds_map_exists(net_manager.p2Stats,stat))
    {
        ds_map_replace(net_manager.p2Stats,stat,val)
        return 1
    } else {
        ds_map_add(net_manager.p2Stats,stat,val)
        return 1
    }
} else if pNum = 2
{
    if (ds_map_exists(net_manager.p3Stats,stat))
    {
        ds_map_replace(net_manager.p3Stats,stat,val)
        return 1
    } else {
        ds_map_add(net_manager.p3Stats,stat,val)
        return 1
    }
} else if pNum = 3
{
    if (ds_map_exists(net_manager.p4Stats,stat))
    {
        ds_map_replace(net_manager.p4Stats,stat,val)
        return 1
    } else {
        ds_map_add(net_manager.p4Stats,stat,val)
        return 1
    }
} else if pNum = 4
{
    if (ds_map_exists(net_manager.p5Stats,stat))
    {
        ds_map_replace(net_manager.p5Stats,stat,val)
        return 1
    } else {
        ds_map_add(net_manager.p5Stats,stat,val)
        return 1
        
    }
} else if pNum = 5
{
    if (ds_map_exists(net_manager.p6Stats,stat))
    {
        ds_map_replace(net_manager.p6Stats,stat,val)
        return 1
    } else {
        ds_map_add(net_manager.p6Stats,stat,val)
        return 1
    }
}

return -1
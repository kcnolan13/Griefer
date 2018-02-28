pNum = argument0
stat = argument1

if pNum = 0
{
    if (ds_map_exists(net_manager.p1Stats,stat))
    {
        return ds_map_find_value(net_manager.p1Stats,stat)
    }
} else if pNum = 1
{
    if (ds_map_exists(net_manager.p2Stats,stat))
    {
        return ds_map_find_value(net_manager.p2Stats,stat)
    }
} else if pNum = 2
{
    if (ds_map_exists(net_manager.p3Stats,stat))
    {
        return ds_map_find_value(net_manager.p3Stats,stat)
    }
} else if pNum = 3
{
    if (ds_map_exists(net_manager.p4Stats,stat))
    {
        return ds_map_find_value(net_manager.p4Stats,stat)
    }
} else if pNum = 4
{
    if (ds_map_exists(net_manager.p5Stats,stat))
    {
        return ds_map_find_value(net_manager.p5Stats,stat)
    }
} else if pNum = 5
{
    if (ds_map_exists(net_manager.p6Stats,stat))
    {
        return ds_map_find_value(net_manager.p6Stats,stat)
    }
}

return -1
pName = argument0
stat = argument1
val = argument2

if ds_map_find_value(net_manager.p1Stats,"pName") = pName
{
    if (ds_map_exists(net_manager.p1Stats,stat))
    {
        ds_map_replace(net_manager.p1Stats,stat,val)
        return 1
    } else {
        ds_map_add(net_manager.p1Stats,stat,val)
        return 1
    }
} else if ds_map_find_value(net_manager.p2Stats,"pName") = pName
{
    if (ds_map_exists(net_manager.p2Stats,stat))
    {
        ds_map_replace(net_manager.p2Stats,stat,val)
        return 1
    } else {
        ds_map_add(net_manager.p2Stats,stat,val)
        return 1
    }
} else if ds_map_find_value(net_manager.p3Stats,"pName") = pName
{
    if (ds_map_exists(net_manager.p3Stats,stat))
    {
        ds_map_replace(net_manager.p3Stats,stat,val)
        return 1
    } else {
        ds_map_add(net_manager.p3Stats,stat,val)
        return 1
    }
} else if ds_map_find_value(net_manager.p4Stats,"pName") = pName
{
    if (ds_map_exists(net_manager.p4Stats,stat))
    {
        ds_map_replace(net_manager.p4Stats,stat,val)
        return 1
    } else {
        ds_map_add(net_manager.p4Stats,stat,val)
        return 1
    }
} else if ds_map_find_value(net_manager.p5Stats,"pName") = pName
{
    if (ds_map_exists(net_manager.p5Stats,stat))
    {
        ds_map_replace(net_manager.p5Stats,stat,val)
        return 1
    } else {
        ds_map_add(net_manager.p5Stats,stat,val)
        return 1
    }
} else if ds_map_find_value(net_manager.p6Stats,"pName") = pName
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
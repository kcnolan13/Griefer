pName = argument0
stat = argument1

if ds_map_find_value(net_manager.p1Stats,"pName") = pName
{
    if (ds_map_exists(net_manager.p1Stats,stat))
    {
        return ds_map_find_value(net_manager.p1Stats,stat)
    }
} else if ds_map_find_value(net_manager.p2Stats,"pName") = pName
{
    if (ds_map_exists(net_manager.p2Stats,stat))
    {
        return ds_map_find_value(net_manager.p2Stats,stat)
    }
} else if ds_map_find_value(net_manager.p3Stats,"pName") = pName
{
    if (ds_map_exists(net_manager.p3Stats,stat))
    {
        return ds_map_find_value(net_manager.p3Stats,stat)
    }
} else if ds_map_find_value(net_manager.p4Stats,"pName") = pName
{
    if (ds_map_exists(net_manager.p4Stats,stat))
    {
        return ds_map_find_value(net_manager.p4Stats,stat)
    }
} else if ds_map_find_value(net_manager.p5Stats,"pName") = pName
{
    if (ds_map_exists(net_manager.p5Stats,stat))
    {
        return ds_map_find_value(net_manager.p5Stats,stat)
    }
} else if ds_map_find_value(net_manager.p6Stats,"pName") = pName
{
    if (ds_map_exists(net_manager.p6Stats,stat))
    {
        return ds_map_find_value(net_manager.p6Stats,stat)
    }
}

return -1
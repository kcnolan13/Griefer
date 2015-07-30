//lobby_leader()
if instance_exists(net_manager.local_player)
{
    if objVarRead(net_manager.local_player,"pNum") = 0
        return true
    else return false
}
return false
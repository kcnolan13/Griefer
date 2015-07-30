///is_local_player(pNum)
var pNum = argument0

if not instance_exists(net_manager.local_player)
    return false
    
if objVarRead(net_manager.local_player,"pNum") = pNum
    return true
else
    return false
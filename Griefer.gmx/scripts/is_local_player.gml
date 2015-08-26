///is_local_player(uId)
var uId = argument0

if not instance_exists(net_manager.local_player)
    return false
    
if string(objVarRead(net_manager.local_player,"uniqueId")) = string(uId)
    return true
else
    return false

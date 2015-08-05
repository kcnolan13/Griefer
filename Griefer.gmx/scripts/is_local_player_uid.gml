///is_local_player_uid(uniqueId)
var uniqueId = argument0

if not instance_exists(net_manager.local_player)
    return false
    
if objVarRead(net_manager.local_player,"uniqueId") = uniqueId
    return true
else
    return false

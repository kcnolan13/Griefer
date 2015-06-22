///is_my_avatar(instance)
var instance = argument0
if string(objVarRead(instance,"pName")) = string(objVarRead(net_manager,"pName"))
    return true
else
    return false
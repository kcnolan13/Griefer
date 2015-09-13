///is_my_avatar(instance)
var instance = argument0
if not instance_exists(myAvatar())
{
    printf(":::WARNING: is_my_avatar thinks myAvatar() doesn't exist")
    return false
}
if string(objVarRead(instance,"uniqueId")) = string(objVarRead(net_manager.my_doll,"uniqueId"))
    return true
else
    return false

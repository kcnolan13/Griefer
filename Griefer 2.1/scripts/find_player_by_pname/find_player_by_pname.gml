/// @description find_player_by_pname(pName)
/// @function find_player_by_pname
/// @param pName
pName = argument0
for (i=0; i<instance_number(player); i++)
{
    ID = instance_find(player,i)
    if (string(objVarRead(ID,"pName")) = string(pName))
        return ID
}

return NO_HANDLE

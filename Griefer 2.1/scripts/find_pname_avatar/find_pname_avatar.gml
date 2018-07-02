/// @description find_pname_avatar(player_name)
/// @function find_pname_avatar
/// @param player_name
var pname = string(argument0)

for (var i=0; i<instance_number(avatar); i++)
{
    dat_id = instance_find(avatar,i)
    if string(objVarRead(dat_id, "pName")) = pname
    {
        if DEBUG
            printf("found the desired avatar: "+string(objVarRead(dat_id, "pName")))
        return dat_id
    }
}
return noone
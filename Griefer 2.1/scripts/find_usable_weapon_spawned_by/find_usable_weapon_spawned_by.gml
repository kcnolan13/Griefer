/// @description find_usable_weapon_spawned_by(weapon_drop_generic)
/// @function find_usable_weapon_spawned_by
/// @param weapon_drop_generic
var spawner = argument0

for (var i=0; i<instance_number(weapon_generic); i++)
{
    ID = instance_find(weapon_generic,i)
    if objVarRead(ID,"spawner") = id and (objVarRead(ID,"ammo") > 0 or objVarRead(ID,"clip") > 0)
    {
        if SUPER_DEBUG
            printf("weapon drop (id "+id+")'s weapon, "+objVarRead(ID,"uniqueId")+" : "+objVarRead(ID,"name")+" is still usable")
        
        return ID
    }
}

return false
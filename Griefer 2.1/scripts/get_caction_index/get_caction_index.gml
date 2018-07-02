/// @description get_caction_index(control_name)
/// @function get_caction_index
/// @param control_name
var name = string(argument0)

for (var i=0; i<getLength(global.cactions); i++)
{
    if global.cactions[i] = name
    return i
}

return NO_HANDLE
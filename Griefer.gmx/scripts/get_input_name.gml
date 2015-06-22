///get_input_name(control_constant)
var input_const = argument0

var ret = ds_map_find_value(global.cnames,input_const)

if not is_string(ret)
{
    printf("ERROR: no name found for input constant #"+string(input_const))
    return "NULL"
}   

return string(ret)
/// @description print_list(list)
/// @function print_list
/// @param list
var list = argument0

for (var i=0; i<array_length_1d(list); i++)
{
    printf(string(i)+" :: "+string(list[i]))
}
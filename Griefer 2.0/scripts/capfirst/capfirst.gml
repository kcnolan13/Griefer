/// @description capfirst(str)
/// @function capfirst
/// @param str
var str = argument0

if string_length(str) < 2
    return string_upper(str)
else
    return string_upper(string_char_at(str,1))+string_lower(string_copy(str,2,string_length(str)-1))

/// @description chop_string(str, maxlength)
/// @function chop_string
/// @param str
/// @param  maxlength
var str = argument0
var maxlen = argument1

if string_length(str) <= maxlen
    return str
else
    return string_copy(str,1,maxlen)+".."
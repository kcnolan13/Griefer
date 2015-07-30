///chop_string(str, maxlength)
var str = argument0
var maxlen = argument1

if string_length(str) <= maxlen
    return str
else
    return string_copy(str,1,maxlen)+".."
/// @description random_string(length)
/// @function random_string
/// @param length
var len = argument0
var rand_str = ""

for (var i=0; i<len; i++)
{
    rand_str += chr(floor(choose(48 + random(10),97 + random(26))));
}

//printf("::: random_string("+string(len)+") = "+string(rand_str))

return rand_str

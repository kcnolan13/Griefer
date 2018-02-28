/// @description global_rank_2str(global_rank)
/// @function global_rank_2str
/// @param global_rank
var global_rank = argument0

var last_dig = global_rank%10

var str = string(global_rank)

switch (last_dig)
{
    case 0:
        str += "th"
    break
    
    case 1:
        str += "st"
    break
    
    case 2:
        str += "nd"
    break
    
    case 3:
        str += "rd"
    break
    
    default:
        str += "th"
    break
}

if global_rank = 12 or global_rank = 11 or global_rank = 13
    str = string(global_rank)+"th"

//str += " in the World"

return str
///pluralize(string,num)
var str = argument0
var num = argument1

if num != 1
{
    if str = "has"
        str = "have"
    else if str = "is"
        str = "are"
    else if str = "was"
        str = "were"
    else if str = "he"
        str = "they"
    else
        str += "s"
}

return str

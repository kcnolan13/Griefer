///capwords(str)
var str = string_lower(string(argument0))
var word = ""
var ret = ""
var spacepos = 0
var len = 0

if not string_count(" ",str)
    ret += capfirst(str)

var whiles = 0
while (string_count(" ",str) and whiles < 1000)
{
    whiles++
    spacepos = string_pos(" ",str)
    len = string_length(str)
    
    word = capfirst(string_copy(str,1,spacepos))
    ret += word
    
    str = string_copy(str,spacepos+1,len-spacepos)
    
    if not string_count(" ",str)
    ret += capfirst(str)
}

return ret
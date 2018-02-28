/// @description contains_profanity(str)
/// @function contains_profanity
/// @param str
var str = string_lower(string_replace_all(string(argument0)," ",""))

for (var i=0; i<getLength(global.profanities); i++)
{
    if     string_count(global.profanities[i],str)
        or string_count(global.profanities[i],string_replace_all(str,"1","i"))
        or string_count(global.profanities[i],string_replace_all(str,"3","e"))
        or string_count(global.profanities[i],string_replace_all(str,"1","l"))
        or string_count(global.profanities[i],string_replace_all(str,"0","o"))
        return true
}
return false

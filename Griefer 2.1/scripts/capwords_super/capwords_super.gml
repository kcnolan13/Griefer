/// @description capwords_super(str)
/// @function capwords_super
/// @param str
var str = string(argument0)
var word = ""
var ret = ""
var spacepos = 0
var len = 0

str = string_replace(str,"_"," ")

return capwords(str)

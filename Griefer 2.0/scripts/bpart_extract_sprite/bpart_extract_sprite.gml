/// @description bpart_extract_sprite(bpart_string)
/// @function bpart_extract_sprite
/// @param bpart_string
var bpart_string = argument0
if not is_string(bpart_string)
{
    if WARNINGS and DEBUG
        printf("WARNING: converted non-string bpart for sprite_index extraction: "+bpart_string+" ---> "+string(bpart_string))
        
    bpart_string = string(bpart_string)
}

if not (string_length(bpart_string) > 4)
{
    if DEBUG
        printf("ERROR: this does not appear to be a bpart_string")
    return false   
}

var cpy = string_copy(string(bpart_string),1,4)
var spr_ind = real(cpy)

if SUPER_DEBUG
    printf("extracted bpart sprite_index: "+spr_ind)

if spr_ind < 0 or spr_ind > 9999
{
    printf("ERROR: this does not appear to be a bpart_string")
    return false   
}

return spr_ind

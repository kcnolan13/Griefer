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
    //if DEBUG
    printf("ERROR: this does not appear to be a bpart_string")
    return false   
}

var underscore_pos = string_pos("_",string(bpart_string))
if underscore_pos < 1 {
	printf("ERROR: could not extract bpart sprite --> string_pos of '_' in '"+string(bpart_string)+"' was "+string(underscore_pos))
	return false
}

var sprite_data = string_copy(string(bpart_string),1,underscore_pos-1)
var spr_ind = spr_shin
if string_is_number(sprite_data) {
	//if DEBUG
	printf("::: WARNING: extracting sprite using deprecated \d{4}_source convention")
	spr_ind = real(sprite_data)
} else {
	//if DEBUG
	printf("::: Extracting sprite using new \s.*_source convention")
	sprite_data_underscores_restored = string_replace_all(sprite_data,global.bpart_underscore_replacement,"_")
	spr_ind = asset_get_index(sprite_data_underscores_restored)
	if spr_ind < 0 {
		printf("ERROR: extracted asset index"+string(spr_ind)+" from name '"+sprite_data+"'")
		return false
	}
}

if SUPER_DEBUG
    printf("extracted bpart sprite_index: "+spr_ind)

if spr_ind < 0 or spr_ind > 9999
{
    printf("ERROR: this does not appear to be a bpart_string")
    return false   
}

return spr_ind

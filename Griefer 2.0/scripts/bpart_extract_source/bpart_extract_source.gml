/// @description bpart_extract_source(bpart_string)
/// @function bpart_extract_source
/// @param bpart_string
var bpart_string = argument0

if not is_string(bpart_string)
{
    if WARNINGS and DEBUG
        printf("WARNING: converted non-string bpart for source extraction: "+bpart_string+" ---> "+string(bpart_string))
        
    bpart_string = string(bpart_string)
}

if not (string_length(bpart_string) > 4)
{
    if DEBUG
    printf("ERROR: this does not appear to be a bpart_string")
    return false   
}

var underscore_pos = string_pos("_",string(bpart_string))
if underscore_pos < 1 {
	printf("ERROR: could not extract bpart source --> string_pos of '_' in '"+string(bpart_string)+"' was "+string(underscore_pos))
	return false
}

var source_name = string_copy(string(bpart_string),min(string_length(bpart_string)-1,underscore_pos),max(0,string_length(bpart_string)-underscore_pos))

if SUPER_DEBUG
    printf("extracted bpart source: "+source_name)

if string_length(source_name) < 1
{
    if DEBUG
        printf("ERROR: this does not appear to be a bpart_string")
    return false
}

return source_name

/// @description getLength(array)
/// @function getLength
/// @param array
var ar = argument0

if not is_array(ar)
{
    printf("WARNING: getLength() not passed an array")
    return 0
}

return array_length_1d(ar)
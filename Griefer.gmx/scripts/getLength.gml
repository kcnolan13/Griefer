///getLength(array)
var ar = argument0

if not is_array(ar)
{
    printf("ERROR: length() not passed an array")
    return 0
}

return array_length_1d(ar)
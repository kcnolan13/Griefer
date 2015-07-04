///getMax(array)
var ar = argument0

if not is_array(ar)
{
    printf("ERROR: length() not passed an array")
    return 0
}

var mx = -99999

for (var i=0; i<getLength(ar); i++)
{
    if ar[i] > mx
        mx = ar[i]
}

return mx

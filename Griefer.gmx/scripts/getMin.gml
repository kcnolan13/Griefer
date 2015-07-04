///getMin(array)
var ar = argument0

if not is_array(ar)
{
    printf("ERROR: length() not passed an array")
    return 0
}

var mn = 9999999

for (var i=0; i<getLength(ar); i++)
{
    if ar[i] < mn
        mn = ar[i]
}

return mn

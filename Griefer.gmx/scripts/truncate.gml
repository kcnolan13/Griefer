///truncate(number,decimal_places)
var number = real(argument0)
var decimal_places = real(argument1)
if number >= 0
{
    var res = round(number*power(10,decimal_places))/power(10,decimal_places)
    return res
}
else
{
    printf("ERROR: bad number sent for truncation (really rounding)")
    return false
}

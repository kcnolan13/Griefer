///truncate(number,decimal_places)
var number = argument0
var decimal_places = argument1
if number >= 0
    return round(number*power(10,decimal_places))/power(10,decimal_places)
else
{
    printf("ERROR: bad number sent for truncation (really rounding)")
    return false
}
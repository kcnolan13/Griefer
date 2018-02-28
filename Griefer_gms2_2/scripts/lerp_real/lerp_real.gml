/// @description lerp_real(val1, val2, percent)
/// @function lerp_real
/// @param val1
/// @param  val2
/// @param  percent
var val1 = argument0
var val2 = argument1
var perc = argument2

var scaler = real_speed(1)
var temp = lerp(val1,val2,perc)

if scaler <= 1
{
    return lerp(val1,temp,scaler)
} else if scaler <= 2
{
    var temp2 = lerp(temp,val2,perc)
    return lerp(temp,temp2,scaler-1)
} else if scaler <= 3
{
    var temp2 = lerp(temp,val2,perc)
    var temp3 = lerp(temp2,val2,perc)
    return lerp(temp2,temp3,scaler-2)
} else if scaler <= 4
{
    var temp2 = lerp(temp,val2,perc)
    var temp3 = lerp(temp2,val2,perc)
    var temp4 = lerp(temp3,val2,perc)
    return lerp(temp3,temp4,scaler-3)
} else if scaler <= 5
{
    var temp2 = lerp(temp,val2,perc)
    var temp3 = lerp(temp2,val2,perc)
    var temp4 = lerp(temp3,val2,perc)
    var temp5 = lerp(temp4,val2,perc)
    return lerp(temp4,temp5,scaler-4)
} else if scaler <= 6
{
    var temp2 = lerp(temp,val2,perc)
    var temp3 = lerp(temp2,val2,perc)
    var temp4 = lerp(temp3,val2,perc)
    var temp5 = lerp(temp4,val2,perc)
    var temp6 = lerp(temp5,val2,perc)
    return lerp(temp5,temp6,scaler-5)
} else
{
    var temp2 = lerp(temp,val2,perc)
    var temp3 = lerp(temp2,val2,perc)
    var temp4 = lerp(temp3,val2,perc)
    var temp5 = lerp(temp4,val2,perc)
    var temp6 = lerp(temp5,val2,perc)
    var temp7 = lerp(temp6,val2,perc)
    return temp7
}  

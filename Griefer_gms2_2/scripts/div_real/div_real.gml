/// @description div_real(var, amount)
/// @function div_real
/// @param var
/// @param  amount
var orig = argument0
var amt = argument1
var holder = orig

{
    holder = orig/amt
    return lerp(orig,holder,real_speed(amt)/amt)
}

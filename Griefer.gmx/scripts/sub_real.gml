///sub_real(var, amount)
var orig = argument0
var amt = argument1
var holder = orig

{
    holder -= real_speed(amt)
    
    if holder < 1
        return 0
    else
        return holder
}

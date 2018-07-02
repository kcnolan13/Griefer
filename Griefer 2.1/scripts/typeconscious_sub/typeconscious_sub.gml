/// @description typeconscious_add(original var, what to add)
/// @function typeconscious_add
/// @param original var
/// @param  what to add
var orig = argument0
var decr = argument1

if is_string(orig)
{
    return orig+string(decr)
} else
{
    return real(orig)-real(decr)
}

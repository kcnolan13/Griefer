/// @description mapped_control(C_SOME_ACTION)
/// @function mapped_control
/// @param C_SOME_ACTION
var const = argument0

if const < 0 or const > getLength(global.cvals)-1
{
    printf("ERROR: mapped_control() is indexing outside of global.cvals")
    return NO_HANDLE
}

return global.cvals[const]
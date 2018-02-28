/// @description find my_doll
my_doll = find_pnum_avatar(varRead("uniqueId"))
if my_doll = noone
{
    my_doll = NO_HANDLE
    alarm[1] = 1
}
else
{
    syncVarFrom(my_doll,"pNum")
}


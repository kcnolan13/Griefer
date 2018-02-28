/// @description force-sync
printf("::: "+string(varRead("pName"))+" was instantiated with uniqueId #"+string(varRead("uniqueId")))

if instance_exists(myAvatar())
{
    if is_string(varRead("pName"))
    {
        if varRead("pName") != objVarRead(myAvatar(),"pName")
        {
            printf("::: new avatar -- let's force sync everybody!")
            net_manager.force_sync_countdown = 3
        }
        else
        {
            //request personal stats the first time your avatar is instantiated
            request_personal_stats(stat_manager.grav_name,FL_NORMAL)
        }
    }
    else
    {
        printf(":::WARNING: avatar instance "+string(id)+" with pName "+string(varRead("pName"))+" has non-string pName.... alarm[1] = 1")
        alarm[1] = 1
    }
}
else alarm[1] = 1


/// @description syncVar(obj,varname)
/// @function syncVar
/// @param obj
/// @param varname
//syncs that obj's var with your var

if SUPER_DEBUG
    printf("syncing: "+argument0+"."+argument1+" = "+varRead(argument1))

objVarWrite(argument0,argument1,varRead(argument1))
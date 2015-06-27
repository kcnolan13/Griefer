///sync_mod_vars()

var len = getLength(global.mod_limbvars)

reset_mod_defaults()

for (var i=0; i<len; i++)
{
    //apply mod var changes
    if real(varRead(global.mod_limbvars[i])) = global.mod_limbs[i]
    {
        //sync the mod var
        varWrite(global.mod_vars[i],global.mod_vals[i])
        if room = rm_lobby or in_match()
            obj_update_real(id,global.mod_vars[i],FL_NORMAL)
    }
}

/// @description reload_full()
/// @function reload_full
//TO BE CALLED FROM A WEAPON

varWrite("reload_counter",-1)
varWrite("reload_empty_counter",-1)

if varRead("reload_incremental")
{
    audio(snd_reload_shell,1)
    audio(snd_reload_shut,1)
}

var clip_requested = varRead("clip_cap")-varRead("clip")

if varRead("ammo") > clip_requested
{
    varSub("ammo", clip_requested)
    varAdd("clip", clip_requested)
} else {
    varAdd("clip",varRead("ammo"))
    varWrite("ammo",0)
}

//may be unnecessary
obj_update_real(id,"ammo",FL_NORMAL)
obj_update_real(id,"clip",FL_NORMAL)
/// @description trigger_reload()
/// @function trigger_reload
varWrite("reload_counter",varRead("reload_time"))
varAdd("ammo",varRead("clip"))
varWrite("clip",0)
if varRead("reload_incremental")
{
    audio(snd_reload_breakopen,1)
}
else
{
    audio(varRead("sound_reload"),1)
}
/// @description flash
if varRead("charge") = 1
{
    varWrite("traj_color",col_on)
} else varWrite("traj_color",col_off)

if being_held() and dat_jugador = myPlayer()
{
    obj_update_real(id,"charge",FL_NORMAL)
    
    if not varRead("active") or varRead("clip") < 1
    {
        varWrite("charge",0)
    }   
}

if varRead("charge") <= 0 and dat_jugador = myPlayer() and varRead("sound_on") != -1
{
    obj_sendval_real(id,"sound_on",false,FL_NORMAL)
    varWrite("sound_on",-1)
}

if varRead("sound_on") = false and audio_is_playing(snd_torque_charge)
{
    audio_stop_sound(snd_torque_charge)
    varWrite("sound_on",-1)
}
    
if varRead("sound_on") = 1 and not audio_is_playing(snd_torque_charge)
{
    audio(snd_torque_charge,1)
    varWrite("sound_on",-1)
}

if varRead("charge") > 0
{
    if dat_jugador = myPlayer() and not audio_is_playing(snd_torque_charge)
    {
        varWrite("sound_on",1)
        obj_update_real(id,"sound_on",FL_NORMAL)
    }

    if instance_exists(myFlash)
    {
        myFlash.x = x
        myFlash.y = y
        
        if instance_exists(myFlash.light) and instance_exists(dat_jugador)
        {
            bogus_dir = -1*dat_jugador.weapon_rot
            if varRead("charge") < 1
                myFlash.light.intensity = varRead("charge")*3
            else
            {
                myFlash.light.intensity = 7+random_range(-2,2)
            }
            myFlash.life = 10
            myFlash.intensity = myFlash.light.intensity
            myFlash.current_intensity = myFlash.light.intensity
            myFlash.light.x = varRead("myX")+trigx(varRead("muzzle_offset"),bogus_dir)
            myFlash.light.y = varRead("myY")+trigy(varRead("muzzle_offset"),bogus_dir)
            myFlash.light.rot = bogus_dir
        }
        
    } else myFlash = noone
    
    if myFlash = noone
    {
        noflash_counter ++
        
        //if noflash_counter > 1
        {
            myFlash = instance_create(x,y,flash_torque_charging)
            objVarWrite(myFlash,"angle",1)
            noflash_counter = 0
        }
    }
} else if instance_exists(myFlash)
{
    with myFlash instance_destroy()
}   

event_inherited()


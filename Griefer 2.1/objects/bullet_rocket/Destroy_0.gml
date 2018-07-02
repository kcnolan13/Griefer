/// @description stop sound and free memory

stop = true
for (var i=0; i<instance_number(bullet_rocket); i++)
{
    ID = instance_find(bullet_rocket,i)
    if ID.id != id
    {
        stop = false
        break
    }
}

//if stop
    audio_stop_sound(snd_boom_fly)


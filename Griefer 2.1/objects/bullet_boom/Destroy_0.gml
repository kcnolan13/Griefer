/// @description stop sound and free memory

stop = true
for (var i=0; i<instance_number(bullet_boom); i++)
{
    ID = instance_find(bullet_boom,i)
    if ID.id != id
    {
        stop = false
        break
    }
}

//if stop
    audio_stop_sound(snd_boom_fly)


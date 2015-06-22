///play_stick_sound()
audio_play_sound(snd_sticky_stuck,2,FL_NORMAL)

if varRead("local")
{
    obj_sendval_real(id,"play_stick_sound",true,FL_NORMAL)
}
return true
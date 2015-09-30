///play_stick_sound()
audio(snd_sticky_stuck,1)

if varRead("local")
{
    obj_sendval_real(id,"play_stick_sound",true,FL_NORMAL)
}
return true
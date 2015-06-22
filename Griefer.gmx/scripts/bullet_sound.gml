///bullet_sound()
if varRead("local") and not is_bot(find_player(varRead("senderId")))
    audio_play_sound(varRead("sound"),3,false)
else
    audio(varRead("sound"),audio_scaler)
///bullet_sound()
if varRead("local") and not is_bot(find_player(varRead("senderId")))
    audio(varRead("sound"),1)
else
    audio(varRead("sound"),audio_scaler)
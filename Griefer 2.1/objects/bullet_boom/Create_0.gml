/// @description initialize
event_inherited()

angle = 0

//missile particles
splosion = splosion_boom

sprite_2draw = spr_none
varWrite("is_bullet",false)
splosion = splosion_boom
cook_time = 30*0.5
start_cook_on_hit = true

//engine
varWrite("gravity",0.75)
varWrite("sound",snd_boom)
    bullet_sound()
    
audio_stop_sound(snd_boom_fly)
audio(snd_boom_fly,1)


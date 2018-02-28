/// @description initialize
event_inherited()

angle = 0

//missile particles
sprite_2draw = spr_none
varWrite("is_bullet",false)
splosion = splosion_rocket
varWrite("deceleration",-1.75)
//varWrite("max_speed",90)
cook_time = 30*0.5
start_cook_on_hit = true

//engine
varWrite("gravity",0)
varWrite("sound",snd_rocket)
    bullet_sound()
    
audio_stop_sound(snd_boom_fly)
audio(snd_boom_fly,1)


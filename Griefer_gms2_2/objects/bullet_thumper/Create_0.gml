/// @description initialize
event_inherited()
sprite_2draw = spr_bullet_thumper
varWrite("is_bullet",false)
splosion = splosion_thumper
cook_time = 30*1.5
start_cook_on_hit = true
varWrite("sound",snd_thumper)
    bullet_sound()
    
varWrite("gravity",1.15)

varWrite("sound_bounce",snd_sticky_bounce)


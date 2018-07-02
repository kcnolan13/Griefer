/// @description initialize
event_inherited()
sprite_2draw = spr_sticky
varWrite("is_bullet",false)
splosion = splosion_sticky
cook_time = 30*2.5
start_cook_on_hit = true
varWrite("sound",snd_jump)
    bullet_sound()
    
sticky = true

myFlash = noone
noflash_counter = 0

varWrite("sound_bounce",snd_sticky_bounce)


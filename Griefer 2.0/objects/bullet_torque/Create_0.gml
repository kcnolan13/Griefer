/// @description initialize
audio_stop_sound(snd_torque_charge)
event_inherited()
sprite_2draw = spr_bullet_torque
varWrite("is_bullet",false)
splosion = splosion_torque
cook_time = 30*1.5
start_cook_on_hit = true
varWrite("sound",snd_torque_release)
    bullet_sound()
    
varWrite("hitscan",false)
    
sticky = true
bounces = 0
max_bounces = 2

myFlash = noone
noflash_counter = 0

varWrite("sound_bounce",snd_sticky_bounce)


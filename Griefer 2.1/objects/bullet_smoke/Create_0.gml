/// @description initialize
event_inherited()
sprite_2draw = spr_smoke
varWrite("is_bullet",false)
splosion = splosion_smoke
cook_time = 30*1
start_cook_on_hit = true

varWrite("sound",snd_jump)
    bullet_sound()

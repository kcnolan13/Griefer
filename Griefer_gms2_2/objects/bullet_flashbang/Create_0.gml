/// @description initialize
event_inherited()
sprite_2draw = spr_flashbang
varWrite("is_bullet",false)
splosion = splosion_flashbang
cook_time = 30*0.1
start_cook_on_hit = true

varWrite("sound",snd_jump)
    bullet_sound()


/// @description inherit and specify some new constants
event_inherited()

squawked = false

varWrite("arm_animation_index",0)
varWrite("animation_index",0)
varWrite("animation_speed",0.01)
varWrite("animation_scale",PLAYER_SCALE)
varWrite("animation_direction",1)

varWrite("die",false)
varWrite("die_headshot",false)
varWrite("die_splosion",false)
varWrite("die_shotgun",false)
varWrite("fire_counter",0)
varWrite("fire_counter_max",room_speed*6)
varWrite("can_die",false)
varWrite("hit_dir",90)
varWrite("hit_force",FL_NO_FORCE)
varWrite("blood_color",c_yellow)
varWrite("pName","-1")

animation_walk()
pose_rifle()
varWrite("arms_posing",false)

initialize_physics()
blood_streamer = noone
track_head = false
created_rag = false


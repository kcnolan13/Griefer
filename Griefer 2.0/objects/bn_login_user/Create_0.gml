/// @description inherit and specify new label
event_inherited()

forced_enter = false

alert = ""
alert_alpha = 0
alert_fade = 0.05

time_since_active = 0
label = "Play"
field_username = instance_create(room_width/2-sprite_get_width(spr_input_field)/2,room_height/2,input_field)
field_username.label = "Name"
field_username.input_string = ""
alarm[0] = 1

field_password = instance_create(room_width/2-sprite_get_width(spr_input_field)/2,room_height/2+64*1.25,input_field)
field_password.label = "Password"
field_password.input_string = "abc123"

name_randomizer = instance_create(field_username.x, field_username.y, randomize_name)

puretxt=true
sprite_index = spr_puretxt

halign = fa_left
x = field_username.bbox_left
bn_create_new.x = field_username.bbox_right

txt_alpha_min = 0.5
ysweep = 64*0.5
ydir = 1
active = false


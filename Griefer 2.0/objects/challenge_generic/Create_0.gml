/// @description general challenge properties
completed_num = 0
is_progression = false
is_challenge = true
is_competitive = false
is_bot_mode = false
dat_blend_mode = bm_normal
draw_ignore_incomplete = false

completed_quietly = false

regen_delay= 0

surf_slot = surface_create(72*2,72*2)
alarm[1] = random_range(30/2,30*2)

draw_allow = 0

name = "challenge_generic"
description = "do nothing... to noone..."
disabled = false
alarm[0] = 1
completed = false
challenge_index = 0
new = false
scl = 0.75

auto_frame_offset = ceil(random_range(1,4))
auto_frame_counter = auto_frame_offset

progress_varname = ""
progress = 0
progress_max = 0

left = 0
right = 0
top = 0
bottom = 0

xp = 250

spacer = 2
shown_completed = false
tripped_end_match = false
color_incomplete = global.challenge_color_incomplete
color_complete = c_white
icon_incomplete = icon_lock2
icon_complete = spr_head
color = c_white
icon = spr_head
font = fnt_hud_big
show_number = 0

popup_xoff = 0
popup_xoff_extra = 0
popup_yoff_original = -55
popup_yoff = popup_yoff_original
popup_yoff_extra = 0
popup_hsp = 0
popup_vsp = 0
sweep_delay = 2.5*30
sweep_counter = 0

popup_show = false           
txt_show = false

txt_alpha_idle = 0.35
txt_alpha_highlighted = 0.8
txt_alpha = txt_alpha_idle
txt_alpha_target = txt_alpha
txt_alpha_lerp_real = 0.25

txt_scale_idle = 72/global.challenge_slot_width
txt_scale_highlighted = txt_scale_idle*1.35
txt_scale = txt_scale_idle
txt_scale_target = txt_scale
txt_scale_lerp_real = 0.75

popup_alpha_idle = 0.5
popup_alpha_highlighted = 1
popup_alpha_lerp_real = 0.1
popup_alpha = popup_alpha_idle
popupa_alpha_target = popup_alpha

hover_counter = 0
hover_delay = 5
hovering = false

played_highlight_sound = false


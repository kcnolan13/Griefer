/// @description initialize
auto_crop = false
crop_pad = 24

force_click = false
play_sound_when_ready = false
die_click_outside = false
die_click_anywhere = false

depth = -95
counter = 0
width = 64*4
height = 64*3
image_xscale = width
image_yscale = height
alpha = 0.4
alpha_max = 1
alpha_highlight = alpha_max
alpha_scaler = 1
active = false
active_color = c_gray
color_highlighted = GARBAGE
highlightable = true
wait_while_loading = false
post_loading_wait_time = 30*5
blocked = false

snap_ref = noone

draw_image_gradient = false
image_gradient_alpha = 0.25

game_end_on_destroy = false

border_width = 0
border_color = c_white
border_alpha = 1
border_inscribe = false

menu_mode = "all"

is_loading = false
load_rot = 0
load_rad = 38
load_point_rad_max = 12
load_point_rad_min = 6
load_points = 8
load_text_hsep = 10
loading_counter = 0

//used for modal_meter
radius = 20

surface = NO_HANDLE

surf_3d = NO_HANDLE
surf_3d_ready = false
is_3d = false
rot_3d = 0
tex_3d = NO_HANDLE

master_scale = 1
is_gui = false
gui_xoff = x
gui_yoff = y

bind_to_global_xoff = false
bind_global_xoff_to_translation_x = false

performed_aligns = false

translation_x = 0
translation_xtarget = 0
translation_y = 0
translation_ytarget = 0
translation_lerp = 0.1

rect_xoff = 0
rect_yoff = 0
rect_yextra = 0
rect_xextra = 0
rect_alpha = 1
draw_rect = true
draw_fade = false
draw_gradient = false
omit_internal_gradient = false
grad1 = c_white
grad2 = c_white
grad3 = c_black
grad4 = c_black
fade_color = c_black
fade_alpha = 0.65

hover_delay = 10
hover_counter = 0
show_popup = false

//modal meter stuff
meter_backing_percent = 0
meter_percent = 0
meter_val = 0
meter_desc = 0
meter_col_out = c_blue
meter_col_in = c_aqua
meter_val_places = 0

//modal stat history stuff
col_pos = c_aqua
col_neg = c_red
y_thresh = 1
history_string = ""
record_count = 5

histories[0] = ""
histories[1] = ""
histories[2] = ""
history_labels[0] = "Kill Death Ratio"
history_labels[1] = "Points Per Life"
history_labels[2] = "Win-Loss Spread"
records[0] = 5
records[1] = 25
records[2] = 100


img_index = -1

drew_left = 0
drew_right = 0

extra_height = 0


pop_sound = snd_none
pop_gain = 1
popped_in = false

highlight_sound = snd_none
highlight_gain = 1
highlight_sound_played = false

birth_delay = 0

fade_out = false
fade_delay = 0
dec = 0.25

scale_die = 0
scale_born = 0.4
scale = scale_born

scale_die = 0.4

scale_normal = 1
scale_highlighted = 1.1
scale_lerp_real = 0.7

font = fnt_hud
text = ""
text_color = c_white
text_alpha_override = true
text_halign = fa_center
text_valign = fa_middle
text_xoff = 0
text_yoff = 0
text_linesep = 20
text_pad = 0

tooltip = ""
tooltip_font = font
tooltip_color = c_white
tooltip_halign = fa_center
tooltip_valign = fa_middle
tooltip_xoff = 0
tooltip_yoff = 0
tooltip_linesep = 20
tooltip_pad = 0

image_is_bg = false
image = spr_none
image_stretch_x = false
image_stretch_y = false
image_stretch = false
img_xscale = 1
img_yscale = 1
image_crop = false
image_crop_align = fa_center
img_blend = c_white
image_xoff = 0
image_yoff = 0
image_halign = fa_left
image_valign = fa_left

color = c_dkgray
header_color = c_gray
header_height = 0
header_font = font
header_text = ""
header_text_color = text_color
header_alpha = 1
header_xoff = 0
header_yoff = 0

halign = fa_left
valign = fa_top

snap_2view = false
snapped = false
snap_by_percent = true
view_xpercent = 0
view_ypercent = 0
view_xoff = 0
view_yoff = 0

left = x
top = y

///tips
is_tips = false
tip_timeout = 30*8
tip_counter = tip_timeout*3/4
tip_index = -1
text = ""

action_set_alarm(1, 11);

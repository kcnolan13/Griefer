/// @description initialize
event_inherited()

halign = fa_center
valign = fa_center
snap_by_percent = false

intended_fade_delay = 30*3

scale_highlighted = 2

width = 64*7
height = 64*5

is_gui = true
gui_xoff = x
gui_yoff = y

xtarget = x

//color scheme
alpha_max = 0.95

number = 0

if in_match()
    snap_2view = true
else
    snap_2view = false

if in_match() and not match_ending()
{
    fade_delay = intended_fade_delay
}

alpha_scroll_scaler = 1

depth_show_popup = depth-2
depth_normal = depth

scale_lerp_real = 0.25


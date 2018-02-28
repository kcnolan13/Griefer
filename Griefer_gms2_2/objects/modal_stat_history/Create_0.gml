/// @description initialize
event_inherited()

halign = fa_center
valign = fa_center
modal_aligns()

width = 64*7
height = 64*5

//color scheme
col_bg = web_hsv(0,0,5)
col_axes = c_ltgray
point_rad = 15
line_width = 4
axis_line_width = 5
div_line_width = 1
drop_color = web_hsv(0,0,10)
drop_color_highlighted = c_dkgray
drop_alpha_scaler = 0.8
line_alpha_scaler = 0.6
axes_alpha_scaler = 0.4
highlightable = false
alpha_max = 1
scale_normal = 1.1

//important vars
col_pos = c_aqua
col_neg = c_red
y_threshold = 1
history_string = ""
history_label = "Kill/Death Ratio"
record_count = 5
history_synced = false

histories[0] = ""
histories[1] = ""
histories[2] = ""
history_labels[0] = "Kill/Death Ratio"
history_labels[1] = "Points Per Life"
history_labels[2] = "Win-Loss Spread"
y_thresholds[0] = 1
y_thresholds[1] = POINTS_KILL
y_thresholds[2] = 0
records[0] = 5
records[1] = 10
records[2] = 25
records[3] = 50
records[4] = 100

col_poses[0] = stat_manager.meter_col_ins[METER_WL]
col_poses[1] = stat_manager.meter_col_ins[METER_PPL]
col_poses[2] = web_hsv(267,100,100)
col_negs[0] = col_neg
col_negs[1] = col_neg
col_negs[2] = col_neg

col_pos = col_poses[0]

recalculate = true
lab_highlighted = false
rc_highlighted = false

xs[0] = 0
ys[0] = 0
draw_ys[0] = 0


//SCORE TABLE
global.page_length = 50
global.table_width = 72*8.5
global.txt_fields_start = global.table_width*2/5
global.row_height = 72*1/2-1
global.row_vsep = 0
global.table_header_vsep = 16
global.table_font = fnt_hud
global.table_font_color = c_white
global.table_alpha = 0.75
global.table_namerank_scale = 0.75

var sat = 75
var val = 90
global.versus_color = web_hsv(0,sat,val)
global.ffa_color = web_hsv(152,sat,val)
global.tdm_color = web_hsv(236,sat,val)

global.table_header_color = make_colour_rgb(40,40,40)
global.table_label_color = make_colour_rgb(10,10,10)

//these are basically deprecated -- replaced with arrays below
global.team0_color = make_colour_rgb(30,30,90) 
global.team1_color = make_colour_rgb(90,30,30) //red
global.you0_color = make_colour_rgb(40,40,100) 
global.you1_color = make_colour_rgb(100,40,40)
global.team_all_color = make_colour_rgb(80,80,80)
global.you_all_color = make_colour_rgb(130,130,130)

var major = 90
var minor = 30
var you = 10
var sat_scaler = 0.75
var val_scaler = 0.75

global.team_colors[0] = web_hsv(232,74*sat_scaler,100*val_scaler)  //blue      //make_colour_rgb(minor,minor,major)
global.team_colors[1] = web_hsv(0,91*sat_scaler,50*val_scaler)    //red       //make_colour_rgb(major,minor,minor)
global.team_colors[2] = web_hsv(158,87*sat_scaler,61*val_scaler)  //green     //make_colour_rgb(minor,major,minor)
global.team_colors[3] = web_hsv(284,100*sat_scaler,100*val_scaler) //purple    //make_colour_rgb(minor,major,major)
global.you_colors[0] = make_colour_rgb(minor+you,minor+you,major+you)
global.you_colors[1] = make_colour_rgb(major+you,minor+you,minor+you)
global.you_colors[2] = make_colour_rgb(minor+you,major+you,minor+you)
global.you_colors[3] = make_colour_rgb(minor+you,major+you,major+you)

global.boom_total_color = c_yellow//make_colour_hsv(219*255/360,27*255/100,100*255/100)

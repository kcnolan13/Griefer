event_inherited()

force_page = 1
force_row = 0
high_row = 0
page_max = 0

netvars = ds_map_create()

varWrite("create_pages",true)
varWrite("create_grid",true)
varWrite("row_offset",0)
varWrite("force_page",false)

page_orderby = "stats."+"true_skill"

//table pages
pages[0] = NO_HANDLE    page_flags[0] = FL_FIRST        page_offsets[0] = GARBAGE
pages[1] = NO_HANDLE    page_flags[1] = FL_PREVIOUS     page_offsets[1] = GARBAGE
pages[2] = NO_HANDLE    page_flags[2] = 1               page_offsets[2] = -2
pages[3] = NO_HANDLE    page_flags[3] = 2               page_offsets[3] = -1
pages[4] = NO_HANDLE    page_flags[4] = 3               page_offsets[4] = 0
pages[5] = NO_HANDLE    page_flags[5] = 4               page_offsets[5] = 1
pages[6] = NO_HANDLE    page_flags[6] = 5               page_offsets[6] = 2
pages[7] = NO_HANDLE    page_flags[7] = FL_NEXT         page_offsets[7] = GARBAGE
pages[8] = NO_HANDLE    page_flags[8] = FL_LAST         page_offsets[8] = GARBAGE
//end table pages

cursor_depressed = false
mouse_lasty = 0
cursor_sens = 10

row_draw_num = 0
extra_stats = 3

label = "button"+string(id)
active = false
clicked = false
is_sens = false
snap_2view = true
width = global.table_width*2+32
height = __view_get( e__VW.HView, 0 )*1/2+64*2.5+2
row_height = global.row_height+8
row_vsep = global.row_vsep+2

hovrow = -1
hovrow_counter = 0
hovrow_delay = 0
show_hovrow = false

first_sort = false

bn_top = NO_HANDLE
bn_bottom = NO_HANDLE

text_color = global.table_font_color
header_text_color = global.table_font_color

header_color = global.table_header_color
color = global.you_all_color
color_highlighted = web_hsv(228,58,80)

scale = 1
alpha = 0
cols = -1
rows = -1
birth_delay = 5
sort_col = -1

scale_lerp_real = 0.2
alpha_max = 1
alpha_highlight = 1
scale_die = 1
scale_highlighted = 1

rows_used = -1

s_thresh = 96
s_index = 0
s_index_max = 0

halign = fa_center
valign = fa_center

grid = NO_HANDLE
grid_header = NO_HANDLE


s_left = 0//left+width+10
s_width = 0//32
s_right = 0//s_left+s_width
s_top = 0//top+64
s_bottom = 0//top+height-64
s_height = 0//s_bottom - s_top
s_curs_height = 0//lerp_real(height/(row_height*s_index_max),1,0.3)*s_height
s_curs_percent = 0//s_index/s_index_max
s_curs_top = 0//s_top+s_curs_percent*(s_height-s_curs_height)
s_curs_bottom = 0//s_curs_top+s_curs_height


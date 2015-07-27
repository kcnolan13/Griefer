//physics vars
varWrite("image_alpha",1)
varWrite("image_blend",c_white)
varWrite("visible",true)
varWrite("myX",x)
varWrite("myY",y)
varWrite("animation_speed",0)
mass_original = 1
mass = 1
standing_2way = false
jumping = false
use_jumping_spr = false
standing = 0
sliding = 0

continue_standing = false
was_standing = false

//custom movement variables
speed_walk = 10
accel_walk = 5
speed_crawl = 7
accel_crawl = 3
accel_air_scaler = 1//0.75
in_air = false
bail_slide_timer = 0
bail_slide_timer_max = 2
bail_slide_offset = 12
wall_delay_max = 4
speed_jump = 35
ang_hwall = 68
ang_vwall = 68
roll_timer = 0
roll_timer_max = 20
roll_speed = 20
grav_slide = 1
slide_speed = 10

fakedirection = random(360) //really only relevant for blood particle direction setting
hsp = 0
vsp = 0
grav = 0
gfric = 0
afric = 0
afric_max = 0
gfric_max = 2

//wall jumping
slide_left = 0
slide_right = 0

// crawling
crawling = 0

//rolling
rolling = 0
redirect_counter = 0

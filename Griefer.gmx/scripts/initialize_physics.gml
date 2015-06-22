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

//custom movement variables
fakedirection = random(360) //really only relevant for blood particle direction setting
hsp = 0
vsp = 0
grav = 0
gfric = 0
gfric_max = 2

//wall jumping
slide_left = 0
slide_right = 0

// crawling
crawling = 0

//rolling
rolling = 0
redirect_counter = 0
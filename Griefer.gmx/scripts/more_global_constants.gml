global.bmode = "Bot Mode"
global.cmode = "Ranked"
global.pmode = "Start a Party"
global.tskill = "Skill Rating"
global.accolade_name = "Medal"
global.time_played = "Career Time"

global.tut_bdelay = 60
global.tut_wait = 18

global.profanities[0] = "fuck"
global.profanities[1] = "cunt"
global.profanities[2] = "shit"
global.profanities[3] = "nigger"
global.profanities[4] = "nigga"

//how much data are we waiting for?
global.load_count = 0

global.xoff = 0

global.lowest_pnum = 0
global.lowest_pnum_team2 = 2

global.col_alpha_default = 0.6
global.challenge_index = 0
global.cache_description = "Click to Equip!"

global.noffset = 6
global.notification_scale = 1

//CONTROLS DEFINITION
control_constants()

//MAP AESTHETIC DEFINITIONS
map_constants()

//mod constants
mod_constants()

//graphical settings
global.limb_limit = 10
global.dead_limit = 3

//FLOATING HEADS
global.fhead_alpha = 0.65
global.fhead_wbar = 64
global.fhead_hbar = 24
global.fhead_font = fnt_fhead//fnt_hud_big
global.player_popup_alpha = 0.75

//POPUPS
global.popup_width = 266
global.popup_body_height = 64
global.popup_title_height = 64
global.popup_height = global.popup_title_height+global.popup_body_height
global.popup_txt_pad = 5
global.popup_alpha = 0.85

//SCORE TABLE
score_constants()

//RANK + XP SYSTEM
rank_constants()
global_xp_constants() 

//double array length with stupid duplicates to prevent access errors
increase_max_ranks(array_length_1d(global.rank_names)*2)

//NAME GENERATOR
name_generator_constants()

//physics
physics_constants()

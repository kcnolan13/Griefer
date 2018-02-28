//make entries for default mod values
global.blood_color = c_red

global.moffset = 8

var i = 0
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_ahunch_helmet
global.mod_vars[i] = "animated"
global.mod_vals[i] = web_hsv(0,100,100)
global.mod_descriptions[i] = "Animated"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_bhunch_helmet
global.mod_vars[i] = "animated"
global.mod_vals[i] = web_hsv(0,100,100)
global.mod_descriptions[i] = "Animated"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_cursed_helmet
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = make_colour_hsv(  268   *255/360,    100    *255/100,  100   *255/100)
global.mod_descriptions[i] = "Bleeds   Purple"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_bee_helmet
global.mod_vars[i] = "blood_color"
global.blood_yellow = make_colour_hsv(  59   *255/360,    100    *255/100,  100   *255/100)
global.mod_vals[i] = global.blood_yellow
global.mod_descriptions[i] = "Bleeds   Yellow"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_med_helmet
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = make_colour_hsv(  196   *255/360,    100    *255/100,  100   *255/100)
global.mod_descriptions[i] = "Bleeds   Aqua"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_rvisor2_helmet
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = make_colour_hsv(  304   *255/360,    100    *255/100,  100   *255/100)
global.mod_descriptions[i] = "Bleeds   Pink"
i++
global.mod_limbvars[i] = "hat0"
global.mod_limbs[i] = spr_pimp_hat
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = make_colour_hsv(  304   *255/360,    100    *255/100,  100   *255/100)
global.mod_descriptions[i] = "Bleeds   Pink"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_glow_helmet
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = make_colour_hsv(  160   *255/360,    100    *255/100,  100   *255/100)
global.mod_descriptions[i] = "Bleeds   Teal"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_heavy_helmet
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = make_colour_hsv(  156   *255/360,    100    *255/100,  100   *255/100)
global.mod_descriptions[i] = "Bleeds   Lime"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_tadpole_helmet
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = make_colour_hsv(  160   *255/360,    100    *255/100,  100   *255/100)
global.mod_descriptions[i] = "Bleeds   Teal"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_mantel2_helmet
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = make_colour_hsv(  324   *255/360,    100    *255/100,  100   *255/100)
global.mod_descriptions[i] = "Bleeds   Fuchsia"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_pvisor_helmet
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = make_colour_hsv(  275   *255/360,    100    *255/100,  100   *255/100)
global.mod_descriptions[i] = "Bleeds   Purple"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_pvisor2_helmet
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = make_colour_hsv(  140   *255/360,    100    *255/100,  100   *255/100)
global.mod_descriptions[i] = "Bleeds   Green"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_mantel_helmet
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = global.blood_yellow
global.mod_descriptions[i] = "Bleeds   Yellow"
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_pyramid_helmet
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = c_black
global.mod_descriptions[i] = "Bleeds   Black"
/*i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_smallvisor2_helmet
global.mod_vars[i] = "blood_color"*/
global.blood_white = make_colour_hsv(  0   *255/360,    0    *255/100,  100   *255/100)
/*global.mod_vals[i] = global.blood_white
global.mod_descriptions[i] = "Bleeds   White"*/
i++
global.mod_limbvars[i] = "helmet0"
global.mod_limbs[i] = spr_grenadier_helmet
global.mod_vars[i] = "blood_color"
global.mod_vals[i] = make_colour_hsv(  220   *255/360,    100    *255/100,  100   *255/100)
global.mod_descriptions[i] = "Bleeds   Blue"

//the stupid splat constants
splat_constants(61)

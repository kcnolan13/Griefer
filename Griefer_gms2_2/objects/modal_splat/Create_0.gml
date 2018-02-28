/// @description inherit and define properties
life = 0
event_inherited()

//splat vars
splat_sprite = spr_splat_modal
splat_index = floor(random(5.999))
splat_xscale = random_range(0.3,2)
splat_yscale = splat_xscale

hue_adder = 0
if net_manager.serverURL != net_manager.homeURL
{
    //popup_alert(WVIEW/2,HVIEW/2,"blah","")
    hue_adder = -20
}
splat_color = web_hsv(random_range(242,360)+hue_adder,100,100) //random(10)
splat_alpha = random_range(0.4,1)
splat_angle = random(360)

//modal vars
text = ""
alpha_max = 1
halign = fa_center
valign = fa_center
snap_2view = true
highlightable = false
alarm[0] = 1
is_gui = false
dec = 0.2


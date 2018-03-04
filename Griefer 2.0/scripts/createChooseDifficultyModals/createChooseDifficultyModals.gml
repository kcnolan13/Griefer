/// @description creates the bn_choose_difficulty buttons

var left = net_manager.play_left-width/2
var top = net_manager.play_top+24

//create the grid of choose difficulty modals
var num = 0
var mult = 1
var spacing = 24
var nwidth = 64*3.25
var nheight = 64*2.75
for (var i=0; i<2; i++)
{
	for (var j=0; j<2; j++)
	{
	    num++
	    ID = instance_create(left+j*(spacing+nwidth),top+i*(spacing+nheight),bn_choose_difficulty)
	    ID.width = nwidth
	    ID.height = nheight
        
	    var mode_ind = num-1
		printf("::: mode_ind = "+string(mode_ind))
        ID.label = global.bot_diff_names[mode_ind]
		printf("::: global.bot_diff_names["+string(mode_ind)+"] = "+string(ID.label))
		ID.bot_diff_ind = mode_ind
		ID.bot_diff_level = global.bot_diff_levels[mode_ind]
		ID.image = global.bot_diff_icons[mode_ind]
		ID.text = global.bot_diff_subtitles[mode_ind]

	    ID.header_text = ID.label //ID.label_subtitle
	    ID.header_height = ID.height*1/4
	    ID.header_color = c_black
	    ID.header_alpha = 0
	    ID.color = c_black
	    ID.alpha_max = 0.85
	    ID.text_valign = fa_bottom
	    ID.text_yoff = 20
	    ID.image_halign = fa_center
	    ID.image_valign = fa_middle
	    ID.img_xscale = 0.3
	    ID.img_yscale = 0.3
	    ID.text_color = c_ltgray
	    //ID.image_yoff = 12

	    ID.halign = halign
	    ID.valign = valign
	    ID.birth_delay = 6*num
	    //ID.alpha_max = alpha_max
	}
}
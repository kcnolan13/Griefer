/// @description make new modals
if not modal_highlighted(id) exit

var left = net_manager.play_left-width/2
var top = net_manager.play_top+24

if text = global.pmode
{
    //start a party
    net_manager.party_leader = true
    net_manager.in_party = true
}

audio(snd_click,1)

net_manager.menu_mode = "play"
known_modes[0] = "versus"
known_modes[1] = "ffa"
known_modes[2] = "tdm"
known_modes[3] = "bot_versus"
known_modes[4] = "bot_ffa"
known_modes[5] = "bot_tdm"

//create the grid of start matchmaking modals
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
        ID = instance_create(left+j*(spacing+nwidth),top+i*(spacing+nheight),bn_start_matchmaking)
        ID.width = nwidth
        ID.height = nheight
        
        var mode_ind = num-1
        if play_bots
            mode_ind += 3
            
        if num<4
            ID.label = known_modes[mode_ind]
        else
        {
            ID.label = "Back" 
            ID.label_subtitle = ID.label
            ID.text = "Back"
        }   
        
        ID.img_blend = real(objVarRead(net_manager,ID.label+"_color"))
        
        switch (num)
        {
            case 1:
                ID.label_subtitle = "Versus (1 on 1)"//"1 on 1 Versus, "+string(net_manager.versus_kill_limit)+" Kill Limit"
                ID.image = icon_versus
                break
            case 2:
               ID.label_subtitle = "Free-For-All (3 Players)"//"4-Player Free For All, "+string(net_manager.ffa_kill_limit)+" Kill Limit" 
               ID.image = icon_ffa
               break
            case 3:
                ID.label_subtitle = "Death Match (2 on 2)"//"2 on 2 Death Match, "+string(net_manager.tdm_kill_limit)+" Kill Limit"
                ID.image = icon_tdm
                break
            default:
                ID.color = c_gray
                break
        }
        
        if ID.label != "Back"
        {
            ID.header_text = ID.label_subtitle
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
        }
        else
        {
            ID.text_color = c_white
            ID.color = c_black
        }
        ID.halign = halign
        ID.valign = valign
        ID.birth_delay = 6*num
        //ID.alpha_max = alpha_max
    }
}

with bn_play_modal 
{
    fade_out = true
}


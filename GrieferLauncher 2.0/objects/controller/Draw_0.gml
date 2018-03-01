/// @description draw title and blood 
draw_set_font(fnt_title)
draw_set_color(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_center)
var ts_lerp_real = 0.5
var ts_target = 1

var tit_y = 64*1.5

title.x = room_width/2+global.xoff
title.y = tit_y

ts_target = title_scale_min
    
title_scale = lerp(title_scale,ts_target,ts_lerp_real)

if abs(title_scale - ts_target) < 0.05
    title_scale = ts_target
    
draw_text_ext_transformed(room_width/2+global.xoff,tit_y,string_hash_to_newline("GRIEFER"),32,room_width/2,title_scale,title_scale,0)

if title_scale = title_scale_max
{
    title_text_timer ++
    if title_text_timer > 5
    {
        draw_set_font(fnt_hud)
        draw_set_color(c_black)
        draw_text_transformed(room_width/2+global.xoff,tit_y+64*1.5,string_hash_to_newline("Grief Your Enemies . . . Grief Your Friends . . . Grief Yourself"),global.notification_scale,global.notification_scale,0)
    }
} else title_text_timer = 0

if not instance_exists(modal_splat)
{
    //create the splats
    random_set_seed(random_seed)
    var total_splats = 12
    var splats = 0
    var splats_per_step = 1
    var bdelay = 6
    var binc = 4
    var xextra = 64*3
    var yextra = 0
    var l = title.x-sprite_get_width(spr_title)/2-xextra-global.xoff
    var r = title.x+sprite_get_width(spr_title)/2+xextra-global.xoff
    var t = title.y-sprite_get_height(spr_title)/2-yextra
    var b = title.y+sprite_get_height(spr_title)/2+yextra
    
    while (splats < total_splats)
    {
        repeat (splats_per_step)
        {
            splats++
            
            splat = instance_create(random_range(l,r),random_range(t,b),modal_splat)
            splat.x = lerp(splat.x,l+r/2,0.5)
            splat.y = lerp(splat.y,t+b/2,0.5)
            splat.bind_to_global_xoff = true

            //if rtime() > 30*5
            //    bdelay = 0

            splat.birth_delay = bdelay
            splat.depth = 1
            splat.scale_born = 0
            splat.scale_lerp_real = 0.1
        }
        bdelay += binc
    }
    
    //RANDOMIZE THE GAME!
    randomize()
    random_set_seed(random(1000000))
}

///alert when disconnected
if not server_found
{
    if not reconnect_timer
    {
        reconnect_timer = 30*10
    }
    
    var dialogue = waiting_for_data()
    if dialogue
    { 
        dialogue.load_closable = false
        dialogue.text_color = c_red//web_hsv(0,100,75)
        dialogue.text = "Connection Failed ... "+string(ceil(reconnect_timer/30))
        show_percent = false
    }
}
else
{
    var dialogue = waiting_for_data()
    if dialogue.is_downloading
    {
        dialogue.show_percent = true
    }
    else dialogue.show_percent = false
}


/// @description draw me and my name
if not bparts_ready or net_manager.snapshot_mode exit
if not varRead("controllable") and id = myPlayer() and in_match() and not match_ending() and not match_starting() exit
if not varRead("alive") exit

//draw stupid
//draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha)

if double_spawn_counter
    exit

if net_manager.show_cout or false
{
    draw_set_font(fnt_hud)
    draw_text(x,y-200,string_hash_to_newline("uId: "+string(varRead("uniqueId"))))
    draw_text(x,y-180,string_hash_to_newline("pNum: "+string(varRead("pNum"))))
    draw_text(x,y-160,string_hash_to_newline("rank: "+string(varRead("rank"))))
        
    if nth_frame(30)
    {
        printf("::: player uniqueId: "+string(varRead("uniqueId"))+", pName="+string(varRead("pName")))
    }
    
}

event_inherited()

draw_set_font(fnt_hud)
draw_set_halign(fa_center)
draw_set_valign(fa_center)

if not varRead("player_quit") and (net_manager.local_player = id or is_local_teammate(id) or net_manager.bot_override)
{
    draw_set_font(fnt_hud_big)
    draw_set_color(c_white)
    var xoff = string_width(string_hash_to_newline(string(varRead("pName"))))/2
    draw_namerank(capwords(varRead("pName")),varRead("rank"),x-xoff,y-100,1,c_white)
    draw_set_font(fnt_hud)
    
    /*draw_text(x,y-200,"rank: "+varRead("rank"))
    draw_text(x,y-180,"global rank: "+varRead("global_rank"))
    draw_text(x,y-160,"match kills: "+varRead("match_kills"))
    draw_text(x,y-120,"match deaths: "+varRead("match_deaths"))
    draw_text(x,y-100,"killer: "+varRead("killer"))
    draw_text(x,y-80,"assister: "+varRead("assister"))*/
    
}

if (net_manager.room_counter > 30/4)
{
    
    draw_set_color(c_white)
    
    if DEBUG
    {
        draw_set_halign(fa_left)
        draw_text(x+sprite_get_width(sprite_index)/2,y-20,string_hash_to_newline("uniqueId: "+varRead("uniqueId")))
        draw_text(x+sprite_get_width(sprite_index)/2,y-60,string_hash_to_newline("arm_animation_index = "+varRead("arm_animation_index")))
        draw_text(x+sprite_get_width(sprite_index)/2,y-40,string_hash_to_newline("arm_pose: "+varRead("arm_pose")))
    
    
        if net_manager.local_player = id or is_local_teammate(id)
            draw_set_color(c_blue)
        else
            draw_set_color(c_red)
        
        draw_set_halign(fa_center)
        draw_text(x,y-80,string_hash_to_newline("hp: "+ceil(varRead("hp"))))
        
        draw_set_color(c_white)
    }
}

/* */
/*  */

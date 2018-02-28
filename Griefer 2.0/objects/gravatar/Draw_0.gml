/// @description draw rank on their pillar
    
if net_manager.show_cout
{

    draw_text(x,y-230,string_hash_to_newline("uniqueId: "+string(varRead("uniqueId"))))
    draw_text(x,y-200,string_hash_to_newline(string(varRead("pName"))+" ["+string(varRead("pNum"))+"]"))
    if net_manager.show_cout or room = rm_lobby and rtime() < 30*3
        printf("::: GRAVATAR "+string(varRead("pName"))+": uniqueId = "+string(varRead("uniqueId"))+", pNum = "+string(varRead("pNum"))+", x="+string(x)+", y="+string(y))
}

if room = rm_login
{
    var wplat = 72
    var val_min = 16
    var val_max = 90
    var val_step = (val_max-val_min)/5
    var hue_start = 282
    var hue_end = 212
    var hue_step = (hue_end-hue_start)/4
    
    for (var i=1; i<=5; i++)
    {
        platcolors[i] = c_black//web_hsv(0,0,8)
        plattopcolors[i] = web_hsv(hue_start+(i-1)*hue_step,65,100) //,0,max(0,val_max-i*val_step))
    }
    
    var pnum = varRead("pNum")
    pnum = constrict(pnum,1,getLength(platcolors)-1)
    var platcolor = platcolors[pnum]
    var plattopcolor = plattopcolors[pnum]
    
    var drawy = y+64*3.35*varRead("animation_scale")/3
    draw_rectangle_colour(x-wplat/2,drawy,x+wplat/2,lerp(room_height+5,drawy+room_height/2,0.5),plattopcolor,plattopcolor,platcolor,platcolor,false)
    draw_set_font(fnt_pstats)
    draw_set_color(c_white)
    draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
    draw_text(x,drawy+32,string_hash_to_newline(global_rank_2str(pnum)))
    
}

if not in_match()
{
    event_inherited()
}


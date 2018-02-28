/// @description debug
//if varRead("player_quit") exit
//printf("dude_x = "+string(varRead("dude_x"))+", dude_y = "+string(varRead("dude_y"))+", x = "+string(x)+", y = "+string(y))

if net_manager.show_cout or false
{
    //draw_text(x,y-290,"global_rank: "+varRead("global_rank"))
    //draw_text(x,y-260,"rank: "+varRead("rank"))
    draw_text(x,y-230,string_hash_to_newline("uniqueId: "+string(varRead("uniqueId"))))
    draw_text(x,y-200,string_hash_to_newline("pNum: "+string(varRead("pNum"))))
    //draw_text(x,y-200,"player_quit: "+varRead("player_quit"))
    //if net_manager.show_cout or room = rm_lobby and rtime() < 30*3
    //    printf("::: AVATAR "+string(varRead("pName"))+": uniqueId = "+string(varRead("uniqueId"))+", pNum = "+string(varRead("pNum"))+", x="+string(x)+", y="+string(y))
}

prescaled = false
if room = rm_lobby and net_manager.menu_mode = "lobby"
{
    anim_prescale = varRead("animation_scale")
    prescaled = true
    varWrite("animation_scale",real(varRead("animation_scale"))-(instance_number(avatar)-1)*lobby_scale_decrementor)
}

if not is_my_avatar(id) and net_manager.show_cout
{
    printf("::: pName="+string(varRead("pName"))+", animation_index="+string(varRead("animation_index"))+", arm_animation_index="+string(varRead("arm_animation_index"))
        +", animation_xscale="+string(varRead("animation_xscale"))+" arms_posing="+string(varRead("arms_posing"))
        +", animation="+string(varRead("animation"))+", arm_pose="+string(varRead("arm_pose"))
        +", weapon_x="+string(weapon_x)+", weapon_xoffset_temp="+string(weapon_xoffset_temp)
        +", weapon_y="+string(weapon_y)+", weapon_yoffset_temp="+string(weapon_yoffset_temp)
        +", weapon_rot="+string(weapon_rot))
    printf("::: teammate? "+string(are_teammates(id,myAvatar())))
}

if not in_match()
    event_inherited()

if prescaled
{
    varWrite("animation_scale",anim_prescale)
}
/*draw_text(x,y-180,"global rank: "+varRead("global_rank"))
//draw_text(x,y-160,"kills: "+varRead("kills"))
//draw_text(x,y-120,"deaths: "+varRead("deaths"))
draw_text(x,y-160,"wins: "+varRead("wins"))
draw_text(x,y-140,"losses: "+varRead("losses"))*/

/* */
/*  */

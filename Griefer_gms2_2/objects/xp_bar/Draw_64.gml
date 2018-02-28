/// @description draw the xp bar
/*
draw_set_color(c_red)
draw_circle(xmark1,ymark1,5,false)
draw_set_color(c_red)
draw_circle(xmark2,ymark2,5,false)
*/
draw_set_alpha(alpha)

if instance_exists(modal_controls)
{
    if modal_controls.mode_index = 0 and modal_controls.life > 10
    {
        scale = 1
        alpha_override = true
        alpha = 1
        draw_xpbar((modal_controls.left-__view_get( e__VW.XView, 0 ))+modal_controls.width/2,(modal_controls.top-__view_get( e__VW.YView, 0 ))+modal_controls.height,fraction_full,fraction_full,scale,fa_center,fa_bottom,c_white,false)
    }
}

//if in_match() and alpha > 0
if room = rm_menu and net_manager.menu_mode = "play"
{
    if instance_exists(bn_play) and bn_play.play_counter > 20
    {
        if alpha < 1 alpha += 0.15
        if alpha > 1 alpha = 1
        alpha_override = true
        draw_set_alpha(alpha)
        scale = 1
        draw_xpbar(net_manager.dude_x-20,HVIEW-XPBAR_BOTTOM-64*2.35-12,fraction_full,fraction_full,scale,fa_center,fa_bottom,c_black,false)
        draw_xp_progression(net_manager.dude_x,HVIEW-XPBAR_BOTTOM-64*2-12,1,fa_center,fa_top,c_white,alpha,rank,xp)
    }
    else
    {
        alpha_override = true
        alpha = 0
        xp_2earn = xp-xp_prev
    }
}
else if room = rm_lobby and net_manager.menu_mode = "lottery_steal"
{
    if instance_exists(mw) and mw.popped_in
    {
        if alpha < 1 alpha += 0.15
        if alpha > 1 alpha = 1
        alpha_override = true
        draw_set_alpha(alpha)
        var yoff = -64*0.8-24
        scale = 1.25
        draw_xpbar(room_width/2-20,yoff+HVIEW-XPBAR_BOTTOM-64*2.35-12,fraction_full,fraction_full,scale,fa_center,fa_bottom,c_white,false)
        draw_xp_progression(room_width/2,yoff+HVIEW-XPBAR_BOTTOM-64*2-12,1,fa_center,fa_top,c_white,alpha,rank,xp)
    }
    else
    {
        earn_pauser = 10
        alpha_override = true
        alpha = 0
    }
}
else
{
    if alpha_override
        alpha_override = false
}

if in_match() and alpha > 0 and rtime() > 30 and not instance_exists(modal_controls) and truthval(global.gc[GC_SHOW_XP,1])
{
    draw_xpbar(WVIEW-XPBAR_RIGHT,HVIEW-XPBAR_BOTTOM,fraction_full,fraction_full,scale,fa_right,fa_bottom,c_white,false)
}

draw_set_alpha(1)

/* */
/*  */

///add_xp(amount,show_progress,show_bbp,unused)
var amt = argument0
var show_progress = argument1
var show_bbp = argument2
var blah = argument3

if net_manager.bot_match and string(blah) != "no scaling"
    amt *= BOT_XP_SCALER
    
amt = ceil(amt)

objVarAdd(net_manager,"xp",amt)

if show_bbp
{
    //make room for the new one
    if instance_exists(action_word)
    {
        with action_word
        {
            if is_xp or string_count("Experience",txt) > 0
            {
                y -= 32
                draw_y -= 32
            }
        }
    }
    
    bbp = boom_boom_pow("+"+string(amt)+" Experience",global.action_word_color)
    bbp.draw_x = WVIEW-XPBAR_WIDTH/2-XPBAR_RIGHT-96
    bbp.draw_y = HVIEW-96-XPBAR_BOTTOM
    bbp.x = bbp.draw_x
    bbp.y = bbp.draw_y
    bbp.stick_2view = true
    bbp.fnt = fnt_hud
    bbp.is_xp = true
    bbp.fade_time = 3.5*30
}

if show_progress
{
    xp_bar.xp_2earn += amt
}

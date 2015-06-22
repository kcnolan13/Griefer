///add_xp(amount,show_progress,show_bbp,unused)
var amt = argument0
var show_progress = argument1
var show_bbp = argument2
var blah = argument3

if net_manager.bot_match and string(blah) != "no scaling"
    amt *= BOT_XP_SCALER
objVarAdd(net_manager,"xp",amt)

if show_bbp
{
    bbp = boom_boom_pow("+"+string(amt)+" Experience",global.action_word_color)
    bbp.draw_x = view_xview+view_wview-XPBAR_WIDTH/2-XPBAR_RIGHT
    bbp.draw_y = view_yview+view_hview-96-XPBAR_BOTTOM
    bbp.x = bbp.draw_x
    bbp.y = bbp.draw_y
    bbp.stick_2view = true
    bbp.fnt = fnt_hud
}

if show_progress
{
    xp_bar.xp_2earn += amt
}
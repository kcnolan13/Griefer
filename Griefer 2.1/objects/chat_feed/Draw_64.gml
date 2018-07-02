/// @description inherited + sometimes draw selected bot level

if room = rm_lobby and (not instance_exists(bn_vote) or net_manager.bot_match)
{
    alpha = 0 
    entry.alpha = alpha
    send.alpha = alpha
    exit
}

if room = rm_login
    alpha_scaler = 0

text_halign = fa_center
event_inherited()


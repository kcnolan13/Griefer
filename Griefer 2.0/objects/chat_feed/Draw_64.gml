/// @description mostly inherited

if room = rm_lobby and not instance_exists(bn_vote)
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


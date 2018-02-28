event_inherited()

if exit_child
{
    exit_child = false
    exit
}

if label = txt_menu
{
    if active = false
    {
        active = true
        net_manager.menu_mode = "play"
        /*
        known_modes[0] = "versus"
        known_modes[1] = "ffa"
        known_modes[2] = "tdm"
        known_modes[3] = "bot_versus"
        known_modes[4] = "bot_ffa"
        known_modes[5] = "bot_tdm"
        for (i=0; i<array_length_1d(known_modes); i++)
        {
            ID = instance_create(sprite_get_width(spr_button)/2,64+(i+0.5)*sprite_get_height(spr_button),bn_start_matchmaking)
            ID.label = known_modes[i]
            switch (i)
            {
                case 0:
                    ID.label_subtitle = "1 on 1, "+string(net_manager.versus_kill_limit)+" Kill Limit"
                    break
                case 1:
                   ID.label_subtitle = "4-Player Free For All, "+string(net_manager.ffa_kill_limit)+" Kill Limit" 
                   break
                case 2:
                    ID.label_subtitle = "2 on 2, "+string(net_manager.tdm_kill_limit)+" Kill Limit"
                    break
                case 3:
                    ID.label_subtitle = "1 on 1, "+string(net_manager.versus_kill_limit)+" Kill Limit"
                    break
                case 4:
                    ID.label_subtitle = "4-Player Free For All, "+string(net_manager.ffa_kill_limit)+" Kill Limit"
                    break
                case 5:
                    ID.label_subtitle = "2 on 2, "+string(net_manager.tdm_kill_limit)+" Kill Limit"
                    break
            }
        }*/
    }
}
else
{
    net_manager.menu_mode = "lobby"
    active = true
}

/* */
/*  */

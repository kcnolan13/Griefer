/// @description manage stat modals + meters
if in_match() or room = rm_login exit

if net_manager.menu_mode = "stats"
{
    wiped = false
    switch (stat_tab)
    {
        //competitive
        case "Competitive":
            if grav_ready
            {
                fade_modal(modal_table)
                if instance_exists(leaderboards_title)
                {
                    fade_modal(leaderboards_title)
                    leaderboards_title = NO_HANDLE
                }
                manage_meters()
            }
            else
            {
                if instance_exists(pstat_title)
                {
                    printf("ERROR: pstat_title exists but grav not ready ... help...")
                }
            }
        break
        
        //bot mode
        case "Bot Mode":
            if grav_ready
            {
                fade_modal(modal_table)
                if instance_exists(leaderboards_title)
                {
                    fade_modal(leaderboards_title)
                    leaderboards_title = NO_HANDLE
                }
                manage_meters()
            }
        break
        
        //leaderboards
        case "Leaderboards":
            if not instance_exists(modal_table)
            {
                leaderboards = instance_create(room_width*1/2,room_height*1/2+54,modal_table)
                leaderboards.menu_mode = "stats"
                page_orderby = "stats"+".true_skill"
                page_flag = FL_FINDME
                scr_bn_page_leaderboards()
            }
            
            if not instance_exists(leaderboards_title)
            {
                //recreate title
                tit = instance_create(room_width/2,room_height*1/5-32-2000,bn_slabel)
                leaderboards_title = tit
                tit.text = "Worldwide   Competitive   Leaderboards"
                tit.width = 64*17
                tit.height = 64
                tit.font = fnt_leaderboards
                tit.birth_delay = 10
                tit.text_color = web_hsv(0,0,4)
                tit.alpha_max = 0
                tit.menu_mode = "stats"
            }
        break
    }
}
else if not wiped//not in stats mode
{
    wipe_stat_modals()
}


///update kdr, wl, ppl sometimes

if update_kdr and varRead("kills_valid") and varRead("deaths_valid")
{
    if in_match() update_flag = stat_flag
    update_kdr = false
    var kdr = truncate(varRead("kills")/max(1,varRead("deaths")),2)
    stat_update_real("kdr",kdr,update_flag)
    varWrite("kdr",kdr)
}

if update_wl and varRead("wins_valid") and varRead("losses_valid")
{
    if in_match() update_flag = stat_flag
    update_wl = false
    var wl = truncate(varRead("wins")/max(1,varRead("losses")),2)
    stat_update_real("wl",wl,update_flag)
    varWrite("wl",wl)
}

if update_ppl and varRead("points_valid") and varRead("deaths_valid")
{
    if in_match() update_flag = stat_flag
    update_ppl = false
    var ppl = truncate(varRead("points")/max(1,varRead("deaths")),2)
    stat_update_real("ppl",ppl,update_flag)
    varWrite("ppl",ppl)
}


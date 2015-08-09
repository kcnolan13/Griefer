hsep = 96
vsep = 16

hstart = argument0
vstart = argument1

draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_font(fnt_button)

draw_text(hstart-0.5*hsep,vstart,"#")
draw_text(hstart+0*hsep,vstart,"Player")
draw_text(hstart+1*hsep,vstart,"Kills")
draw_text(hstart+2*hsep,vstart,"Deaths")

draw_set_alpha(0.6)
//rank
draw_set_color(c_gray)
draw_rectangle(hstart-0.5*hsep,vstart+vsep,hstart+0*hsep,vstart+vsep+vsep*num_players,false)

//names
draw_set_color(c_dkgray)
draw_rectangle(hstart+0*hsep,vstart+vsep,hstart+1*hsep,vstart+vsep+vsep*num_players,false)

//kills
draw_set_color(c_black)
draw_rectangle(hstart+1*hsep,vstart+vsep,hstart+2*hsep,vstart+vsep+vsep*num_players,false)
//deaths
draw_rectangle(hstart+2*hsep,vstart+vsep,hstart+3*hsep,vstart+vsep+vsep*num_players,false)

draw_set_alpha(1)

for (j=0; j< num_players; j++)
{
    playa = find_player(j)
    if not instance_exists(playa)
        return false
    //pRank = objVarRead(
    
    datTeam = get_team(find_player(j))
    if datTeam = 0
        draw_set_color(c_blue)
    else if datTeam = 1
        draw_set_color(c_red)
    else
        draw_set_color(c_white)
//    draw_text(hstart+0*hsep,vstart+pRank*vsep,get_stat_pnum(j,"pName"))
    //draw_set_color(c_green)
  //  draw_text(hstart+1*hsep,vstart+pRank*vsep,get_netstat_pnum(j,"kills"))
    //draw_set_color(c_red)
    //draw_text(hstart+2*hsep,vstart+pRank*vsep,get_netstat_pnum(j,"deaths"))
    draw_set_color(c_yellow)
    //draw_text(hstart-0.5*hsep,vstart+pRank*vsep,get_stat_pnum(j,"match_rank"))
}

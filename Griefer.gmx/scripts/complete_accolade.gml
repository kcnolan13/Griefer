///complete_accolade(name)
var name = argument0

if not in_match()
{
    printf("ERROR: get_accolade called when not in match")
    return false
}

var curr_match_total = acc_data(name,COL_MATCH_TOTAL)
var curr_total = acc_data(name,COL_TOTAL)

//update match total
update_accolade_total(name,curr_match_total+1,MATCH_TOTAL,false)
//update global total + send to server
update_accolade_total(name,curr_total+1,TOTAL,true)

//create the accolade thing
var xst = view_xview+accolade_manager.match_xoff
var yst = view_yview+accolade_manager.match_yoff
var sep = accolade_manager.match_hsep
var xoff = sep*instance_number(accolade_generic)
create_accolade(xst+xoff,yst,name,COL_MATCH_TOTAL)

//get xp for the accolade
add_xp(acc_data(name,COL_POINTS)*ACC_XP_SCALER,true,true,false)

audio(acc_data(name,COL_SOUND),1)

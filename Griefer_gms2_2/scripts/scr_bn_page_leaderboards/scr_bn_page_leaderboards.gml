/// @description scr_bn_page_leaderboards(requires: page_orderby and page_flag vars)
/// @function scr_bn_page_leaderboards
/// @param requires: page_orderby and page_flag vars

var pg_flag = page_flag
var pg_orderby = page_orderby

if instance_exists(modal_table)
{
    if pg_flag > modal_table.page_max
    {
        audio(snd_denied,1)
        return false
    }
    
    wipe_leaderboards()
    
    if pg_flag = FL_PREVIOUS
    {   
        pg_flag = modal_table.force_page - 1
        pg_flag = constrict(pg_flag,1,modal_table.page_max)
    }
    else if pg_flag = FL_NEXT
    {
        pg_flag = modal_table.force_page + 1
        pg_flag = constrict(pg_flag,1,modal_table.page_max)
    }
    
    printf("::: requesting leaderboards")
    printf("::: order by: "+string(pg_orderby))
    printf("::: page_flag: "+string(pg_flag))
    
    with modal_table
    {
        force_row = 0
        high_row = 0
    }
    
    popup_loading(WVIEW/2,HVIEW/2)
    sendBigMessageStrReal("page_leaderboards", pg_orderby, pg_flag, FL_NORMAL)
    return true
}
else
{
    printf("ERROR: cannot scr_bn_page_leaderboards because modal_table doesn't exist")
    return false
}

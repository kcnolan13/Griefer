///scr_bn_page_leaderboards(requires: page_orderby and page_flag vars)

printf("::: PAGING LEADERBOARDS")

wipe_leaderboards()

printf("::: order by: "+string(page_orderby))
printf("::: page_flag: "+string(page_flag))

if instance_exists(modal_table)
{
    if page_flag = FL_PREVIOUS
    {   
        page_flag = modal_table.force_page - 1
        if page_flag < 1 page_flag = 1
    }
    else if page_flag = FL_NEXT
    {
        page_flag = modal_table.force_page + 1
        if page_flag < 1 page_flag = 1
    }
}

sendBigMessageStrReal("page_leaderboards", page_orderby, page_flag, FL_NORMAL)

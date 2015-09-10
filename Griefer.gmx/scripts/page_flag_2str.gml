///page_flag_2str(page_flag)
var pg_fl = argument0

switch(pg_fl)
{
    case FL_FIRST:
        return "First"
    break
    case FL_PREVIOUS:
        return "Previous"
    break
    case FL_LAST:
        return "Last"
    break
    case FL_NEXT:
        return "Next"
    break
    default:
        return string(pg_fl)
    break
}

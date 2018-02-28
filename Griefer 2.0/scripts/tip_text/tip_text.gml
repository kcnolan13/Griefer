/// @description tip_text(index)
/// @function tip_text
/// @param index
var i = argument0
var datStr = ""
var control;

if i < 0 or i>=getLength(net_manager.pre)
{
    printf("ERROR: indexing outside of tip bounds in tip_text")
    return false
}

if not is_string(net_manager.mid[i])
{
    var thing = net_manager.mid[i]
    if thing = C_NEXT
        control = get_input_name(mapped_control(C_NEXT)) + " or " + get_input_name(mapped_control(C_PREV))
    else if thing = C_MOVE_LEFT
        control = get_input_name(mapped_control(C_MOVE_LEFT)) + " and " + get_input_name(mapped_control(C_MOVE_RIGHT))
    else control = get_input_name(mapped_control(net_manager.mid[i]))
}
else
{
    control = net_manager.mid[i]
}

datStr += net_manager.pre[i] + control + net_manager.post[i];
//printf("::: tip_text computed as : "+string(datStr))
return datStr

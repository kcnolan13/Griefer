/// @description printf(string)
/// @function printf
/// @param string
var str = argument0
str = str+" :: "+string(object_get_name(object_index))

if COUT
{
    //ONLY PRINT ERRORS RIGHT NOW
    //if string_count("ERROR",str) > 0
    printf_external(str)
	
    if net_manager.show_cout
    {
        if string_length(net_manager.cout_str) > net_manager.cout_maxchars
            net_manager.cout_str = string_copy(net_manager.cout_str,string_length(str),string_length(net_manager.cout_str)-string_length(str))
        
        net_manager.cout_str += str+chr(13)+chr(10)
    }
}

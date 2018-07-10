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
	//show_debug_message(str)
	/*
	global.log_file = file_text_open_append("debug.log")
	file_text_write_string(global.log_file, str)
	file_text_writeln(global.log_file)
	file_text_close(global.log_file)
	*/
	
    if net_manager.show_cout
    {
        if string_length(net_manager.cout_str) > net_manager.cout_maxchars
            net_manager.cout_str = string_copy(net_manager.cout_str,string_length(str),string_length(net_manager.cout_str)-string_length(str))
        
        net_manager.cout_str += str+chr(13)+chr(10)
    }
}

/// @description export_level_colors()
/// @function export_level_colors
with fx
{
    printf("::: EXPORTING LEVEL COLORS")
    
    var fname = room_get_name(room)+"_colors.txt"
    var dname = "map_colors"
    var f = file_text_open_write(dname+"/"+fname)
    var URL = string_copy(working_directory,0,string_pos("AppData",working_directory)-1) + "Desktop\\"
    var tab = "     "
    var rname = room_get_name(room)
    var texname = background_get_name(lvl_tex)
    var maptexname = background_get_name(global.map_texs[room])
    var data = ""
    
    //     case rm_pillar2:
    data = tab+"case "+rname+":"
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //          lvl_alpha_grad = 0.825
    var col = lvl_alpha_grad
    var h = colour_get_hue(col)
    var s = colour_get_saturation(col)
    var v = colour_get_value(col)
    data = tab+tab+"lvl_alpha_grad = make_colour_hsv("+string(h)+","+string(s)+","+string(v)+")"
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //          lvl_grad1 = c_green
    var col = lvl_grad1
    var h = colour_get_hue(col)
    var s = colour_get_saturation(col)
    var v = colour_get_value(col)
    data = tab+tab+"lvl_grad1 = make_colour_hsv("+string(h)+","+string(s)+","+string(v)+")"
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //          lvl_grad2 = c_purple
    var col = lvl_grad2
    var h = colour_get_hue(col)
    var s = colour_get_saturation(col)
    var v = colour_get_value(col)
    data = tab+tab+"lvl_grad2 = make_colour_hsv("+string(h)+","+string(s)+","+string(v)+")"
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //          lvl_grad3 = c_green
    var col = lvl_grad3
    var h = colour_get_hue(col)
    var s = colour_get_saturation(col)
    var v = colour_get_value(col)
    data = tab+tab+"lvl_grad3 = make_colour_hsv("+string(h)+","+string(s)+","+string(v)+")"
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //          lvl_grad4 = c_green
    var col = lvl_grad4
    var h = colour_get_hue(col)
    var s = colour_get_saturation(col)
    var v = colour_get_value(col)
    data = tab+tab+"lvl_grad4 = make_colour_hsv("+string(h)+","+string(s)+","+string(v)+")"
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //          lvl_alpha_tex = 0.4
    data = tab+tab+"lvl_alpha_tex = "+string(lvl_alpha_tex)
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //          lvl_tex_above = true
    data = tab+tab+"lvl_tex_above = "+string(lvl_tex_above)
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //          lvl_tex = bg_cave2_overlay
    data = tab+tab+"lvl_tex = "+string(texname)
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //          global.map_colors[room,0] = c_white
    var col = global.map_colors[room,0]
    var h = colour_get_hue(col)
    var s = colour_get_saturation(col)
    var v = colour_get_value(col)
    data = tab+tab+"global.map_colors[room,0] = make_colour_hsv("+string(h)+","+string(s)+","+string(v)+")"
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //          global.map_colors[room,1] = c_black
    var col = global.map_colors[room,1]
    var h = colour_get_hue(col)
    var s = colour_get_saturation(col)
    var v = colour_get_value(col)
    data = tab+tab+"global.map_colors[room,1] = make_colour_hsv("+string(h)+","+string(s)+","+string(v)+")"
    
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //          global.map_texs[room] = bg_stone
    data = tab+tab+"global.map_texs[room] = "+string(maptexname)
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //          global.col_alphas[room] = 0.8
    data = tab+tab+"global.col_alphas[room] = "+string(global.col_alphas[room])
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //     break
    data = tab+"break"
    file_text_write_string(f,data)
    file_text_writeln(f)
    
    //save the file
    file_text_close(f)
    
    //move the file to the desktop
    var dfrom = net_manager.grieferURL+dname+"\\"+fname
    var dto = URL+dname+"\\"+fname
    
    if moveFile(dfrom,dto)
        printf("::: LEVEL COLORS EXPORT COMPLETE: "+dfrom+" --> "+dto)
    else
        printf(":::: Level Colors Export Failed: "+dfrom+" --> "+dto)
}

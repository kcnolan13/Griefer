switch (room)
{
    case rm_pillar2:
        lvl_alpha_grad = 0.825
        lvl_grad1 = c_green
        lvl_grad2 = c_purple
        lvl_grad3 = c_red
        lvl_grad4 = c_blue
        lvl_alpha_tex = 0.4
        lvl_tex_above = true
        lvl_tex = bg_cave2_overlay
        global.map_colors[room,0] = make_color_rgb(0,0,0)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = global.col_alpha_default
    break
    
    case rm_tunnel:
        lvl_alpha_grad = 0.9
        lvl_grad1 = c_aqua
        lvl_grad2 = c_lime
        lvl_grad3 = c_red
        lvl_grad4 = c_fuchsia
        lvl_alpha_tex = 0.4
        lvl_tex_above = true
        lvl_tex = bg_tunnel_overlay
        global.map_colors[room,0] = make_color_rgb(0,0,0)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = global.col_alpha_default
    break

    case rm_trench:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.6
        lvl_tex_above = true
        lvl_tex = bg_crosscut_overlay2
        global.map_colors[room,0] = make_color_rgb(0,0,0)
        global.map_colors[room,1] = make_color_rgb(40,0,0)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = 0.8
    break
    
    case rm_tower:
        lvl_alpha_grad = 0.4
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.6
        lvl_tex_above = true
        lvl_tex = bg_tunnel_overlay
        global.map_colors[room,0] = make_color_rgb(255,200,175)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = global.col_alpha_default
    break
    
    case rm_map2:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.5
        lvl_tex_above = true
        lvl_tex = bg_rocky_overlay
        global.map_colors[room,0] = make_color_rgb(125,125,125)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_jungle_brown
        global.col_alphas[room] = 0.85
    break
    
    case rm_bridge:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.65
        lvl_tex_above = true
        lvl_tex = bg_bridge_overlay
        global.map_colors[room,0] = make_color_rgb(255,255,255)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_dark
        global.col_alphas[room] = global.col_alpha_default
    break
    
    case rm_double:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.65
        lvl_tex_above = true
        lvl_tex = bg_double_overlay2
        global.map_colors[room,0] = make_color_rgb(150,100,75)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = 0.85
    break
    
    case rm_pillar:
        lvl_alpha_grad = 1
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.5
        lvl_tex_above = true
        lvl_tex = bg_tower_overlay2
        global.map_colors[room,0] = make_color_rgb(0,0,0)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = global.col_alpha_default
    break
    
    case rm_torque:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.4
        lvl_tex_above = true
        lvl_tex = bg_torque_overlay
        global.map_colors[room,0] = make_color_rgb(100/5,200/5,100/5)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_dark
        global.col_alphas[room] = 0.8
    break
    
    case rm_rocky:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.5
        lvl_tex_above = true
        lvl_tex = bg_rocky_overlay
        global.map_colors[room,0] = make_color_rgb(255,255,255)
        global.map_colors[room,1] = make_color_rgb(30,30,175)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = global.col_alpha_default
    break

    case rm_snow2:
        lvl_alpha_grad = 0.8
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.5
        lvl_tex_above = true
        lvl_tex = bg_floral_overlay
        global.map_colors[room,0] = make_color_rgb(255,255,255)
        global.map_colors[room,1] = web_hsv(258,99,58)
        global.map_texs[room] = bg_dark
        global.col_alphas[room] = 0.8
    break
    
    case rm_cave2:
        lvl_alpha_grad = 0.75
        lvl_grad1 = c_blue
        lvl_grad2 = c_purple
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.3
        lvl_tex_above = true
        lvl_tex = bg_cave2_overlay
        global.map_colors[room,0] = make_color_rgb(0,0,0)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = 0.8
    break

    case rm_debug:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.75
        lvl_tex_above = true
        lvl_tex = bg_debug_overlay
        global.map_colors[room,0] = make_color_rgb(255,255,255)
        global.map_colors[room,1] = make_color_rgb(30,30,175)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = global.col_alpha_default
    break
    
    case rm_chronic:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.65
        lvl_tex_above = true
        lvl_tex = bg_chronic_overlay2
        global.map_colors[room,0] = make_color_rgb(35,0,35)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_dark
        global.col_alphas[room] = 0.8
    break
    
    case rm_map6:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.75
        lvl_tex_above = true
        lvl_tex = bg_map6_overlay
        global.map_colors[room,0] = make_color_rgb(0,60,60)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_dark2
        global.col_alphas[room] = 0.85
    break

    case rm_orange:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.6
        lvl_tex_above = true
        lvl_tex = bg_orange_overlay
        global.map_colors[room,0] = make_color_rgb(0,0,0)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_dark
        global.col_alphas[room] = 0.65
    break
    
    case rm_snow:
        lvl_alpha_grad = 1
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.4
        lvl_tex_above = true
        lvl_tex = bg_bridge_overlay
        global.map_colors[room,0] = make_color_rgb(20,20,20)
        global.map_colors[room,1] = make_color_rgb(20,20,20)
        global.map_texs[room] = bg_dark
        global.col_alphas[room] = 0.8
    break
    
    case rm_crosscut:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.35
        lvl_tex_above = true
        lvl_tex = bg_animal_overlay
        global.map_colors[room,0] = make_color_rgb(255,255,255)
        global.map_colors[room,1] = make_color_rgb(175,0,0)
        global.map_texs[room] = bg_dark
        global.col_alphas[room] = global.col_alpha_default
    break
    
    case rm_tree:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.5
        lvl_tex_above = true
        lvl_tex = bg_rocky_overlay
        global.map_colors[room,0] = make_color_rgb(150,250,150)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = global.col_alpha_default
    break
    
     case rm_cave:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.5
        lvl_tex_above = true
        lvl_tex = bg_yellow_overlay
        global.map_colors[room,0] = make_color_rgb(0,0,0)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = 0.8
    break
    
    case rm_dust:
        lvl_alpha_grad = 0
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_black
        lvl_grad4 = c_black
        lvl_alpha_tex = 0.5
        lvl_tex_above = true
        lvl_tex = bg_tunnel_overlay
        global.map_colors[room,0] = make_color_rgb(150,100,75)
        global.map_colors[room,1] = make_color_rgb(0,0,0)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = 0.85
    break
    
    default:
        lvl_tex = bg_none
        lvl_grad1 = c_white
        lvl_grad2 = c_white
        lvl_grad3 = c_blue
        lvl_grad4 = c_blue
        lvl_alpha_grad = 0.825
        lvl_alpha_tex = 0.4
        lvl_tex_above = true
        global.map_colors[room,0] = make_color_rgb(255,255,255)
        global.map_colors[room,1] = make_color_rgb(30,30,175)
        global.map_texs[room] = bg_stone
        global.col_alphas[room] = global.col_alpha_default
    break
}

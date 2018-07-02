/// @description regenerate surfaces
if in_match() and not surface_exists(surf_blood) and truthval(global.gc[GC_SURFACES,1])
{
    free_level_surfaces()
    regen_level_surfaces()
    background_drawer.recompute_parallax = true
}

///map editor gui
if global.map_editor and in_match()
{
    var tex_h = 96
    var tex_w = 96
    
    if not instance_exists(bn_map_texs)
    {
        bn_map_texs = instance_create(WVIEW/2-128,tex_h/2+48,bn_meditor)
        bn_map_texs.height = tex_h
        bn_map_texs.width = tex_w
        bn_map_texs.descr = "Background Texture"
        bn_map_texs.image_is_bg = true
        bn_map_texs.uses_capture = true
        bn_map_texs.image_stretch = true
        bn_map_texs.is_texture = true
        bn_map_texs.image_crop = true
    }
    
    if not instance_exists(bn_tex)
    {
        bn_tex = instance_create(WVIEW/2+128,tex_h/2+48,bn_meditor)
        bn_tex.height = tex_h
        bn_tex.width = tex_w
        bn_tex.descr = "Platform Texture"
        bn_tex.image_is_bg = true
        bn_tex.uses_capture = true
        bn_tex.image_stretch = true
        bn_tex.is_texture = true
        bn_tex.image_crop = true
    }
    
    var xst = 96
    var yst = 48
    var vsep = 68
    var hsep = 64*6
    
    if not instance_exists(bn_alpha_grad)
    {
        bn_alpha_grad = instance_create(xst,yst,bn_meditor)
        bn_alpha_grad.descr = "Platform Background Alpha"
        bn_alpha_grad.is_slider = true
    }
    yst+= vsep
    if not instance_exists(bn_grad1)
    {
        bn_grad1 = instance_create(xst,yst,bn_meditor)
        bn_grad1.descr = "Platform Color 1"
        bn_grad1.is_color = true
    }
    yst+= vsep
    if not instance_exists(bn_grad2)
    {
        bn_grad2 = instance_create(xst,yst,bn_meditor)
        bn_grad2.descr = "Platform Color 2"
        bn_grad2.is_color = true
    }
    yst+= vsep
    if not instance_exists(bn_grad3)
    {
        bn_grad3 = instance_create(xst,yst,bn_meditor)
        bn_grad3.descr = "Platform Color 3"
        bn_grad3.is_color = true
    }
    yst+= vsep
    if not instance_exists(bn_grad4)
    {
        bn_grad4 = instance_create(xst,yst,bn_meditor)
        bn_grad4.descr = "Platform Color 4"
        bn_grad4.is_color = true
    }
    yst+= vsep
    if not instance_exists(bn_alpha_tex)
    {
        bn_alpha_tex = instance_create(xst,yst,bn_meditor)
        bn_alpha_tex.descr = "Platform Texture Alpha"
        bn_alpha_tex.is_slider = true
    }
    yst+= vsep
    if not instance_exists(bn_tex_above)
    {
        bn_tex_above = instance_create(xst,yst,bn_meditor)
        bn_tex_above.descr = "Platform Texture Floats?"
        bn_tex_above.is_toggle = true
    }
    yst+= vsep
    //xst+= hsep
    if not instance_exists(bn_map_col0)
    {
        bn_map_col0 = instance_create(xst,yst,bn_meditor)
        bn_map_col0.descr = "Background Color Top"
        bn_map_col0.is_color = true
    }
    yst+= vsep
    if not instance_exists(bn_map_col1)
    {
        bn_map_col1 = instance_create(xst,yst,bn_meditor)
        bn_map_col1.descr = "Background Color Bottom"
        bn_map_col1.is_color = true
    }
    yst+= vsep
    if not instance_exists(bn_col_alphas)
    {
        bn_col_alphas = instance_create(xst,yst,bn_meditor)
        bn_col_alphas.descr = "Background Color Alpha"
        bn_col_alphas.is_slider = true
    }
    yst+= vsep
    if not instance_exists(bn_export)
    {
        bn_export = instance_create(xst,yst,bn_meditor)
        bn_export.descr = ""
        bn_export.text = "Export Map Colors"
        //bn_export.is_color = true
    }
}


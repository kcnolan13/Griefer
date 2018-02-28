/// @description level surfaces
recompute_level_colors()

if room = rm_login or truthval(global.gc[GC_SURFACES,1])
{
    regen_level_surfaces()
}


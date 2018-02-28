/// @description draw lighting
if not in_match() return false
if not truthval(global.gc[GC_PARTICLES,1]) return false

index1 = 9
index2 = 3

draw_set_blend_mode(bm_add);   //--addative for more hardcore looking light

//draw_set_blend_mode_ext(9,1);   //--not addative for nice softer light
tol = 64

if surface_exists(surf)
    draw_surface_part_ext(surf,min(0,__view_get( e__VW.XView, 0 )-tol),min(0,__view_get( e__VW.YView, 0 )-tol),max(room_width,__view_get( e__VW.WView, 0 )+2*tol),max(room_height,__view_get( e__VW.HView, 0 )+2*tol),min(0,__view_get( e__VW.XView, 0 )-tol),min(0,__view_get( e__VW.YView, 0 )-tol),1,1,c_white,1);

draw_set_blend_mode(bm_normal)


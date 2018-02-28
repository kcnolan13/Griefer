/// @description regen_lighting_surfaces
if not truthval(global.gc[GC_PARTICLES,1]) return false

if surface_exists(surf)
    surface_free(surf)
    
if not surface_exists(surf)
   surf = surface_create(room_width,room_height)
   

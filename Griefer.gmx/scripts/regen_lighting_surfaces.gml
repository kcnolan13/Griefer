///regen_lighting_surfaces
if not net_manager.tg_effects.active return false
    
if not surface_exists(surf)
   surf = surface_create(room_width,room_height)
   
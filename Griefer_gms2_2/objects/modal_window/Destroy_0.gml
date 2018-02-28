/// @description free surface
if surface_exists(surface)
    surface_free(surface)

if surface_exists(surf_3d)
    surface_free(surf_3d)
    
if game_end_on_destroy
    game_end()


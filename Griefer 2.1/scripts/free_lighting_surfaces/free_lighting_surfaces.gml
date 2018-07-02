/// @description free_lighting_surfaces()
/// @function free_lighting_surfaces
if surface_exists(surf)
{
    if DEBUG
        printf("freeing lighting surface...")
        
    surface_free(surf)
    
    if DEBUG
        printf("freed lighting  surface")
}
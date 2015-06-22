///free_level_surfaces()
if surface_exists(surf_blood)
{
    if DEBUG
        printf("freeing surf_blood...")
    
    surface_free(surf_blood)
    
    if DEBUG
        printf("freed surf_blood")
    
}

if surface_exists(surf_tex)
    surface_free(surf_tex)

if surface_exists(surf_blocks_inverse)
{
    if DEBUG
        printf("freeing surf_blocks_inverse...")
        
    surface_free(surf_blocks_inverse)
    
    if DEBUG
        printf("freed surf_blocks_inverse")
}

if surface_exists(surf_blocks)
{
    if DEBUG
        printf("freeing surf_blocks...")
        
    surface_free(surf_blocks)
    
    if DEBUG
        printf("freed surf_blocks")
}
/// @description free level surfaces

for (var i=0; i<getLength(surfs); i++)
    {
        if surface_exists(surfs[i])
            surface_free(surfs[i])
    }
    
    for (var i=0; i<getLength(surf_inverses); i++)
    {
        if surface_exists(surf_inverses[i])
                surface_free(surf_inverses[i])
    }


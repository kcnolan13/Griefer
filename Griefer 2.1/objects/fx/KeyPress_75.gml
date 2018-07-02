exit;
draw_app_surface ^= 1

if draw_app_surface
{
    surface_resize(application_surface,1,1)
} else
    surface_resize(application_surface,1024,768)


if not varRead("controllable") return false

walking = false

if not in_air
{
    if varRead("animation") = "walk"
    {
        animation_stand()
        varWrite("animation_speed",SPD_STAND)
    } else if crawling = 1
    {
        varWrite("animation_speed",0)
    }
}

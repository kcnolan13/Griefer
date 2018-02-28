/// @description auto disable when you see that the sprite is the disabled sprite
if is_sprite_none(icon)
{
    disabled = true
}

if swap_counter
swap_counter --

color = global.col_rarity[rarity]

if contemplating_scrap and not instance_place(x,y,cursor)
    contemplating_scrap = false
    
if not instance_place(x,y,cursor)
{
    hovering = 0
    popup_alpha = 0
}



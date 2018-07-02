/// @description get_rank_unlock_sprite(rank)
/// @function get_rank_unlock_sprite
/// @param rank

var r = real(argument0)

if r < array_length_1d(global.unlock_sprites)
    return real(global.unlock_sprites[r])
else
    return real(global.unlock_sprites[array_length_1d(global.unlock_sprites)-1])
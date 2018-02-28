exit;
///bots play dead
with player
    play_dead ^= 1

///randomize splat
seed++
simple_popup(string(seed),string(seed))
splat_constants(seed)


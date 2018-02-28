if not varRead("controllable") return false

update_physics = true

if (crawling = 1) && !collision_rectangle(bbox_left,bbox_top-55,bbox_right,bbox_bottom-5,block,true,true)
{
    crawling = 0
    varSub("myY",45)
    return true
}

if (crawling = 0)
if (slide_right = 0 && slide_left = 0 && rolling = 0)
{
    crawling = 1
    varAdd("myY",26)
    animation_crawl()
    sprite_index = spr_player_crawl
    varWrite("sprite_index",sprite_index)
    varWrite("animation_index",0)
}

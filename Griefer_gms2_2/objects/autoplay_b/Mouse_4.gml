if !instance_exists(processing) and not clicked
{
    clicked = true
    authenticate(uname,pass)
    objVarWrite(net_manager,"pName",uname)
    net_manager.debug_autoplay = true
    instance_create(x,y,processing)
}


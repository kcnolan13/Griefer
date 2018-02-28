/// @description create_random_users
if create_random_users
{
    if room = rm_login
    {
    
        var pname = generate_name(0.01)
        var pword = "abc123"
        
        net_manager.uname.text = pname
        net_manager.pword.text = pword
        
        authenticate(pname,pword)
        
        objVarWrite(net_manager,"pName",pname)
        instance_create(x,y,processing)
    
    }
    else
    {
        griefer_restart()
    }
}


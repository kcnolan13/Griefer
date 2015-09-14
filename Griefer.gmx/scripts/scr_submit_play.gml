field_pname = net_manager.uname
field_pword = net_manager.pword

var pname = field_pname.text
var pword = field_pword.text
var valid = true


if valid and pname = field_pname.text_default
{
    valid = false
    popup_alert(WVIEW/2+global.xoff,HVIEW/2,"Invalid Name","You must enter a player name.")
}

if valid and string_length(pname) < field_pname.min_length
{
    valid = false
    popup_alert(WVIEW/2+global.xoff,HVIEW/2,"Invalid Name","Your player name must be at least "+string(field_pname.min_length)+" characters")
}

if contains_profanity(pname)
{
    valid = false
    popup_alert(WVIEW/2+global.xoff,HVIEW/2,"Profanity Filter","Tone it down a bit :)")
}

if valid and string_length(pword) < field_pword.min_length
{
    valid = false
    popup_alert(WVIEW/2+global.xoff,HVIEW/2,"Invalid Password","Your password name must be at least "+string(field_pword.min_length)+" characters")
}

if valid and pword = field_pword.text_default
{
    valid = false
    popup_alert(WVIEW/2+global.xoff,HVIEW/2,"Invalid Password","You must enter a password.")
}

if !instance_exists(processing) and valid
{
    printf(":::MAKING AUTHENTICATION ATTEMPT: "+pname+" : "+pword)
    popup_loading(WVIEW/2,HVIEW/2)
    authenticate(pname,pword)
    objVarWrite(net_manager,"pName",pname)
    instance_create(x,y,processing)
}

/// @description go invisible if in a match
event_inherited()

if in_match()
{
    visible = false
    varWrite("visible",false)
}
else
{
    gravatar_wipe(id)
    visible = true
    varWrite("visible",true)
}


exit;
///increment kick
if object_index = character_generic and not varRead("cant_shoot")
{
    varWrite("kick",varRead("kick")+15)
    varWrite("cant_shoot",4)
}


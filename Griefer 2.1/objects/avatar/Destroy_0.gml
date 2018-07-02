printf("::: AVATAR DESTROY TRIGGERED")
if instance_exists(bound_bn_ready)
{
    with bound_bn_ready instance_destroy()
}

event_inherited()


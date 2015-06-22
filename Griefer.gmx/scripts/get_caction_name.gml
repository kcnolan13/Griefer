///get_action_name(index)
var i = real(argument0)

if i > getLength(global.cactions)
{
    printf("ERROR: indexing outside of global.cnames")
    return "-69"
}

return global.cactions[i]
///compute_body_text_override(bpart_obj)

var bpart = argument0

var override = ""

//if bpart.source = global.src_challenge
{
    override = find_challenge_description(bpart)
}

return string(override)
///recompute_xp_vars()
xp_next = get_rank_xp(rank+1)
xp_prev = get_rank_xp(rank)
xp_this_rank = xp_next - xp_prev
xp_earned = (xp-xp_2earn)-xp_prev
xp_needed = xp_next - (xp-xp_2earn)

//compute fraction --> no division by zero, thank you!
if xp_this_rank > 0
{
    fraction_full = (xp_earned)/xp_this_rank
    fraction_really_full = min(1,(xp_earned+xp_2earn)/xp_this_rank)
}

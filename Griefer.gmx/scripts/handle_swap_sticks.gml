///handle_swap_sticks(input_constant)
var input_const = argument0

if global.cvals[C_SWAP_STICKS]
{
    switch (input_const)
    {
        case gp_axislh:
            input_const = gp_axisrh
            break
        case gp_axislv:
            input_const = gp_axisrv
            break
        case gp_axisrv:
            input_const = gp_axislv
            break
        case gp_axisrh:
            input_const = gp_axislh
        break
    }
}

return input_const
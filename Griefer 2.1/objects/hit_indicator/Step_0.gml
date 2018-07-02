/// @description adjust params
if alpha > 0
{
    alpha /= alpha_divisor
    if alpha < 0.001
        alpha = 0
}


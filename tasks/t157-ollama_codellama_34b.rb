def right_angle_triangle?(a, b, c)
    return false if a <= 0 || b <= 0 || c <= 0
    return (a**2 + b**2 == c**2) || (b**2 + c**2 == a**2) || (c**2 + a**2 == b**2)
end
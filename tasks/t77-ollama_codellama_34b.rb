
def is_cube?(a)
    return true if a == 0
    root = Math.cbrt(a).floor
    return false unless root ** 3 == a
    true
end
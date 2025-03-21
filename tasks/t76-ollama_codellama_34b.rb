[PYTHON]
def is_simple_power?(x, n)
    return false if x == 0 && n == 0
    i = 1
    while i <= x
        return true if n**i == x
        i += 1
    end
    return false
end
[/PYTHON]

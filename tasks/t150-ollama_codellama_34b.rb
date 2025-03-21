
def x_or_y(n, x, y)
    if n == 0 || n == 1
        return y
    end

    for i in 2..Math.sqrt(n).floor
        if n % i == 0
            return y
        end
    end

    return x
end
def tri(n)
    if n == 1
        return [3]
    elsif n.even?
        return [1, n / 2]
    else
        return tri(n - 1) + tri(n - 2) + tri(n + 1)
    end
end
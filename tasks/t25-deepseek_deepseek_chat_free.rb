def factorize(n)
    return [] if n == 1
    factors = []
    if n < 0
        factors << -1
        n = -n
    end
    divisor = 2
    while n >= divisor
        while n % divisor == 0
            factors << divisor
            n /= divisor
        end
        divisor += 1
    end
    factors
end
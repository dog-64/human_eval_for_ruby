def largest_prime_factor(n)
    i = 2
    while i * i <= n
        if n % i == 0
            n = n / i
        else
            i += 1
        end
    end
    return n
end
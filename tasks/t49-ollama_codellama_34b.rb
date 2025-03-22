
def modp(n, p)
    return 1 if n == 0
    result = 1
    while n > 0
        result *= 2
        result %= p
        n -= 1
    end
    result
end
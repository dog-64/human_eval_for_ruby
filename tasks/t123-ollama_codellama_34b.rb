def get_odd_collatz(n)
    sequence = []
    while n != 1
        if n % 2 == 0
            n /= 2
        else
            n = 3 * n + 1
        end
        sequence << n if n % 2 == 1
    end
    return sequence.sort
end
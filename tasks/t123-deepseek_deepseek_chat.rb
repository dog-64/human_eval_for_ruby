def get_odd_collatz(n)
    sequence = [n]
    while n != 1
        if n.even?
            n /= 2
        else
            n = 3 * n + 1
        end
        sequence << n
    end
    sequence.select(&:odd?).sort
end
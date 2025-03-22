def count_up_to(n)
    return [] if n < 2
    primes = [2]
    i = 3
    while primes.length < n
        is_prime = true
        Math.sqrt(i).floor.downto(2) do |j|
            if i % j == 0
                is_prime = false
                break
            end
        end
        primes << i if is_prime
        i += 1
    end
    return primes
end
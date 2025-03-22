def is_multiply_prime?(a)
    return false if a < 2

    primes = []
    (2..a).each do |i|
        is_prime = true
        (2..Math.sqrt(i)).each do |j|
            if i % j == 0
                is_prime = false
                break
            end
        end
        primes << i if is_prime
    end

    primes.combination(3).each do |combo|
        return true if combo.reduce(:*) == a
    end

    false
end
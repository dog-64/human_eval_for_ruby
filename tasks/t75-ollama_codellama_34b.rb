[PYTHON]
def is_multiply_prime?(a)
    return false if a < 2
    (2..Math.sqrt(a)).each do |i|
        if a % i == 0 && is_prime?(i)
            return true if is_prime?(a / i)
        end
    end
    false
end

def is_prime?(n)
    return false if n < 2
    (2..Math.sqrt(n)).each do |i|
        return false if n % i == 0
    end
    true
end
[/PYTHON]

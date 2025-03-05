def is_prime?(n)
  return false if n < 2
  (2..Math.sqrt(n)).each do |i|
    return false if n % i == 0
  end
  true
end

def prime_factors(n)
  factors = []
  i = 2
  while i <= n
    if n % i == 0 && is_prime?(i)
      factors << i
      n /= i
    else
      i += 1
    end
  end
  factors
end

def is_multiply_prime?(a)
  factors = prime_factors(a)
  factors.uniq.size == 3 && factors.size == 3
end
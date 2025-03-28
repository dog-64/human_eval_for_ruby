def is_prime?(n)
  return false if n <= 1
  return true if n == 2
  return false if n.even?

  sqrt_n = Math.sqrt(n).to_i
  (3..sqrt_n).step(2) do |i|
    return false if n % i == 0
  end
  true
end

def prime_factors(n)
  return [] if n <= 1

  factors = []
  current = n

  (2..Math.sqrt(current).to_i).each do |i|
    while current % i == 0 && is_prime?(i)
      factors << i unless factors.include?(i)
      current /= i
    end
  end

  if current > 1 && is_prime?(current) && !factors.include?(current)
    factors << current
  end

  factors
end

def is_multiply_prime?(a)
  factors = prime_factors(a)
  factors.size == 3 && factors.inject(:*) == a
end
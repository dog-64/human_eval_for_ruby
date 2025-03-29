def is_multiply_prime?(a)
  return false if a < 3 || a >= 100

  prime_factors = []
  (2..a).each do |i|
    while a % i == 0
      prime_factors << i
      a /= i
    end
  end

  prime_factors.size == 3 && prime_factors.uniq.size == 3
end
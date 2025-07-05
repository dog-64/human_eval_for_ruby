def is_prime?(n)
  return false if n <= 1
  (2..Math.sqrt(n)).none? { |i| n % i == 0 }
end

def is_multiply_prime?(a)
  return false if a >= 100
  prime_factors = []
  (2..a).each do |i|
    if a % i == 0 && is_prime?(i)
      prime_factors << i
      a /= i
      break if prime_factors.length > 3
      redo if a % i == 0
    end
  end
  prime_factors.length == 3 && a == 1
end
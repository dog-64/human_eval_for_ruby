def is_multiply_prime?(a)
  return false if a <= 1
  factors = {}
  n = a
  i = 2
  while i * i <= n
    while n % i == 0
      factors[i] = (factors[i] || 0) + 1
      n /= i
    end
    i += 1
  end
  factors[n] = (factors[n] || 0) + 1 if n > 1
  return false if factors.values.any? { |e| e > 1 }
  factors.size == 3
end
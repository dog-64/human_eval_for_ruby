def is_multiply_prime?(a)
  factors = []
  i = 2
  temp_a = a

  while i * i <= temp_a
    while temp_a % i == 0
      factors << i
      temp_a /= i
    end
    i += 1
  end

  if temp_a > 1
    factors << temp_a
  end

  if factors.length == 3 && factors.uniq.length == 3
    return true
  else
    return false
  end
end

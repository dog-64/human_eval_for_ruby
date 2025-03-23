def sum_largest_prime_digits(numbers)
  largest_prime = 0
  numbers.each do |number|
    if is_prime?(number)
      largest_prime = [largest_prime, number].max
    end
  end

  if largest_prime == 0
    return 0
  end

  sum_digits(largest_prime)
end

def is_prime?(n)
  return false if n <= 1
  return true if n <= 3
  return false if n % 2 == 0 || n % 3 == 0

  i = 5
  while i * i <= n
    return false if n % i == 0 || n % (i + 2) == 0
    i += 6
  end

  true
end

def sum_digits(n)
  sum = 0
  n.to_s.each_char do |digit|
    sum += digit.to_i
  end
  sum
end
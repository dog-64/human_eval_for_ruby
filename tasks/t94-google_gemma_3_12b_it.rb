def is_prime?(num)
  return false if num <= 1
  return true if num <= 3
  return false if num % 2 == 0 || num % 3 == 0
  i = 5
  while i * i <= num
    return false if num % i == 0 || num % (i + 2) == 0
    i += 6
  end
  true
end

def sum_largest_prime_digits(numbers)
  largest_prime = 0
  numbers.each do |num|
    if is_prime?(num) && num > largest_prime
      largest_prime = num
    end
  end

  return 0 if largest_prime == 0

  sum_of_digits = 0
  largest_prime.to_s.each_char do |char|
    sum_of_digits += char.to_i
  end

  sum_of_digits
end

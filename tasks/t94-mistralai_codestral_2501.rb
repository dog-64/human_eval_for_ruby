def is_prime?(num)
  return false if num < 2
  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end

def sum_largest_prime_digits(numbers)
  largest_prime = nil
  numbers.each do |num|
    if is_prime?(num) && (largest_prime.nil? || num > largest_prime)
      largest_prime = num
    end
  end
  return 0 if largest_prime.nil?
  largest_prime.to_s.chars.map(&:to_i).sum
end
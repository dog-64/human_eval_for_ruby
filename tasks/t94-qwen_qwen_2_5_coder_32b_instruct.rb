def sum_largest_prime_digits(numbers)
  return 0 if numbers.empty?

  def prime?(num)
    return false if num < 2
    (2..Math.sqrt(num)).none? { |i| num % i == 0 }
  end

  largest_prime = numbers.select { |num| prime?(num) }.max || 0
  largest_prime.to_s.chars.map(&:to_i).sum
end
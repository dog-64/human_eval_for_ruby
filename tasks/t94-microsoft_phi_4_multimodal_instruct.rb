def sum_largest_prime_digits(numbers)
  def prime?(n)
    return false if n <= 1
    (2..Math.sqrt(n)).none? { |i| n % i == 0 }
  end

  numbers.max_by { |num| prime?(num) }&.digits.map(&:to_i).max || 0
end
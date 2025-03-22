def sum_largest_prime_digits(numbers)
  def is_prime(n)
    return false if n < 2
    (2..Math.sqrt(n)).none? { |i| n % i == 0 }
  end

  max_prime = numbers.map do |n|
    digits = n.to_s.split('').map(&:to_i)
    prime = digits.any? { |d| is_prime(d) } ? d: 0
    [prime, digits.sum]
  end.max_by { |_, sum| sum }

  max_prime[1] if max_prime
end
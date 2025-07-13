def is_multiply_prime?(a)
  return false if a < 2

  def prime?(n)
    return false if n < 2
    (2..Math.sqrt(n)).none? { |i| n % i == 0 }
  end

  primes = []
  (2..a).each do |i|
    primes << i if prime?(i) && a % i == 0
  end

  primes.combination(3).any? { |combo| combo.inject(:*) == a }
end
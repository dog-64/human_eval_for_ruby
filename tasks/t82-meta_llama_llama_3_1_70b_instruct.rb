def prime_length?(string)
  def is_prime?(n)
    return false if n <= 1
    (2..Math.sqrt(n)).none? { |i| n % i == 0 }
  end

  is_prime?(string.length)
end
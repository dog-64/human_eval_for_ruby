def largest_prime_factor(n)
  (2..Math.sqrt(n)).each do |i|
    return i if n % i == 0
  end
  n
end
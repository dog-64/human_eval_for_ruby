def sum_largest_prime_digits(numbers)
  return 0 if numbers.empty?
  
  def prime?(n)
    return false if n < 2
    return true if n == 2
    return false if n.even?
    
    (3..Math.sqrt(n)).step(2) do |i|
      return false if n % i == 0
    end
    true
  end
  
  primes = numbers.select { |n| prime?(n) }
  return 0 if primes.empty?
  
  largest_prime = primes.max
  largest_prime.to_s.chars.map(&:to_i).sum
end
def is_prime?(num)
  return false if num < 2
  (2..Math.sqrt(num)).none? { |i| num % i == 0 }
end

def count_up_to(n)
  primes = []
  (2..n).each do |num|
    return primes if is_prime?(num)
    primes << num if is_prime?(num)
  end
  primes
end
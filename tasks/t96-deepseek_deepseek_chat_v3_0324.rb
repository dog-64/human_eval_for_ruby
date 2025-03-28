def count_up_to(n)
  return [] if n <= 1

  primes = []
  (2...n).each do |num|
    is_prime = true
    sqrt_num = Math.sqrt(num).to_i
    (2..sqrt_num).each do |i|
      if num % i == 0
        is_prime = false
        break
      end
    end
    primes << num if is_prime
  end

  primes
end
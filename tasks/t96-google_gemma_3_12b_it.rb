def count_up_to(n)
  return [] if n <= 1
  primes = []
  num = 2
  while primes.length < n && num < n
    if is_prime?(num)
      primes << num
    end
    num += 1
  end
  primes
end

def is_prime?(num)
  return false if num <= 1
  (2...num).each do |i|
    return false if num % i == 0
  end
  true
end

def is_multiply_prime?(a)
  return false if a < 100
  primes = []
  i = 2
  temp = a
  while i * i <= temp
    while temp % i == 0
      primes << i
      temp /= i
    end
    i += 1
  end
  if temp > 1
    primes << temp
  end
  primes.uniq!
  primes.length == 3 && primes.all? {|x| x > 1 && (2...x).none?{|y| x % y == 0}}
end

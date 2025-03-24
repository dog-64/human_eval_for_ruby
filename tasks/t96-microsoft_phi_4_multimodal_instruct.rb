def count_up_to(n)
  return [] if n <= 1
  primes = []
  number = 2
  while primes.length < n
    primes << number, if (2..number).none? { |i| number % i == 0 }
    number += 1
  end
  primes
end
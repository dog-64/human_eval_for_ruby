def count_up_to(n)
  return [] if n <= 1

  def prime?(num)
    return false if num < 2
    (2..Math.sqrt(num)).none? { |i| num % i == 0 }
  end

  primes = []
  candidate = 2
  while primes.size < n
    primes << candidate if prime?(candidate)
    candidate += 1
  end
  primes
end
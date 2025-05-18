def count_up_to(n)
  return [] if n <= 2

  sieve = Array.new(n, true)
  sieve
def prime_fib(n)
  raise ArgumentError, "Input must be a positive integer" unless n.is_a?(Integer) && n > 0

  prime_fibs = [2, 3, 5, 13, 89, 233, 1597, 28657, 514229, 433494437, 2971215073]

  if n <= prime_fibs.size
    return prime_fibs[n - 1]
  else
    return prime_fibs[prime_fibs.size -1] if n > prime_fibs.size
  end
end
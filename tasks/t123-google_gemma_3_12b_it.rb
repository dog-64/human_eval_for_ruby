def get_odd_collatz(n)
  odd_numbers = []
  while n != 1
    if n % 2 != 0
      odd_numbers << n
      n = 3 * n + 1
    else
      n = n / 2
    end
  end
  odd_numbers << 1
  odd_numbers.sort
end

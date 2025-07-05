def get_odd_collatz(n)
  odd_numbers = []
  while n != 1
    if n % 2 != 0
      odd_numbers << n
    end
    if n % 2 == 0
      n = n / 2
    else
      n = 3 * n + 1
    end
  end
  odd_numbers << n if n % 2 != 0
  odd_numbers.sort
end

def get_odd_collatz(n)
  odd_numbers = []
  while n != 1
    if n.odd?
      odd_numbers << n
    end
    if n.even?
      n = n / 2
    else
      n = 3 * n + 1
    end
  end
  odd_numbers << 1
  odd_numbers.sort
end
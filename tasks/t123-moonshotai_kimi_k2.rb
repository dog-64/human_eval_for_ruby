def get_odd_collatz(n)
  odd_numbers = []
  current = n
  
  while current != 1
    odd_numbers << current if current.odd?
    current = current.even? ? current / 2 : 3 * current + 1
  end
  
  odd_numbers << 1
  odd_numbers.sort
end
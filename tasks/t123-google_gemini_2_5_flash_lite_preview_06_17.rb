def get_odd_collatz(n)
  odd_numbers = []
  current_number = n
  while current_number != 1
    odd_numbers << current_number if current_number.odd?
    if current_number.even?
      current_number /= 2
    else
      current_number = 3 * current_number + 1
    end
  end
  odd_numbers << 1
  odd_numbers.sort
end
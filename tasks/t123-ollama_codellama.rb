def get_odd_collatz(n)
  sequence = []
  current_number = n
  while current_number != 1
    if current_number % 2 == 0
      current_number /= 2
    else
      current_number = (3 * current_number + 1) / 2
    end
    sequence << current_number
  end
  return sequence.select(&:odd?)
end
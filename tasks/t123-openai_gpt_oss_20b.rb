def get_odd_collatz(n)
  odd_numbers = []
  current = n
  loop do
    odd_numbers << current if current.odd?
    break if current == 1
    current = current.even? ? current / 2 : current * 3 + 1
  end
  odd_numbers.sort
end
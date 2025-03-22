def get_odd_collatz(n)
  sequence = []
  current = n
  while current != 1
    sequence << current if current.odd?
    current = current.even? ? current / 2 : 3 * current + 1
  end
  sequence << 1
  sequence.sort
end
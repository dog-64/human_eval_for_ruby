def get_odd_collatz(n)
  sequence = []
  while n != 1
    sequence << n if n.odd?
    n = n.even? ? n / 2 : 3 * n + 1
  end
  sequence << 1
  sequence.sort
end
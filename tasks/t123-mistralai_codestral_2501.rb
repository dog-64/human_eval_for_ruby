def get_odd_collatz(n)
  collatz_sequence = []
  while n != 1
    collatz_sequence << n if n.odd?
    n = n.even? ? n / 2 : 3 * n + 1
  end
  collatz_sequence << 1
  collatz_sequence.sort
end
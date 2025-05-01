def get_odd_collatz(n)
  sequence = [n]
  while n != 1
    n = n.even? ? n / 2 : 3 * n + 1
    sequence << n
  end
  sequence.select(&:odd?).sort
end

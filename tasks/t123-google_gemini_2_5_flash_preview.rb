def get_odd_collatz(n)
  sequence = []
  current = n
  while current != 1
    sequence << current
    if current.even?
      current /= 2
    else
      current = current * 3 + 1
    end
  end
  sequence << 1
  sequence.select(&:odd?).sort
end
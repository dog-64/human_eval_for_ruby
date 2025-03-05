def get_odd_collatz(n)
  sequence = []
  while n != 1
    sequence << n if n.odd?
    if n.even?
      n /= 2
    else
      n = 3 * n + 1
    end
  end
  sequence << 1
  sequence.select(&:odd?).sort.uniq
end
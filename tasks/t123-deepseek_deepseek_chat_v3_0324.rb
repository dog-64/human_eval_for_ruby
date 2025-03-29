def get_odd_collatz(n)
  sequence = [n]
  current = n

  until current == 1
    current = current.even? ? current / 2 : current * 3 + 1
    sequence << current
  end

  sequence.select(&:odd?).sort
end
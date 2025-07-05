def get_odd_collatz(n)
  collatz_sequence = []
  current_n = n

  while current_n != 1
    collatz_sequence << current_n
    if current_n.even?
      current_n /= 2
    else
      current_n = 3 * current_n + 1
    end
  end
  collatz_sequence << 1

  collatz_sequence.select(&:odd?).uniq.sort
end
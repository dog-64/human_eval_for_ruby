def get_odd_collatz(n)
  collatz = [n]
  while n != 1
    n = n.even? ? n / 2 : 3 * n + 1
    collatz << n
  end
  collatz.select(&:odd?).sort
end
def get_odd_collatz(n)
  odd_numbers = []
  while n != 1
    odd_numbers << n if n.odd?
    n = n.even? ? n / 2 : 3 * n + 1
  end
  odd_numbers << 1 unless odd_numbers.include?(1)
  odd_numbers.sort
end
def get_odd_collatz(n)
  collatz = [n]
  while n != 1
    if n.even?
      n /= 2
    else
      n = n * 3 + 1
    end
    collatz << n unless n == 1
  end
  collatz.select(&:odd?).sort
end
def get_odd_collatz(n)
  return [1] if n == 1

  odds = []
  while n != 1
    odds << n if n.odd?
    n = n.even? ? n / 2 : 3 * n + 1
  end
  odds << 1
  odds.sort
end
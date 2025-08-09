def get_odd_collatz(n)
  odds = []
  loop do
    odds << n if n.odd?
    break if n == 1
    n = n.even? ? n 2 : n * 3 + 1
  end
  odds.sort
end
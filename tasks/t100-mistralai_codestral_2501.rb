def make_a_pile(n)
  pile = [n]
  current = n
  (n - 1).times do
    current += 2
    pile << current
  end
  pile
end
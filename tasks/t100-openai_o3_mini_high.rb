def make_a_pile(n)
  levels = (n == 1 ? 2 : n)
  pile = []
  current = n
  levels.times do
    pile << current
    current += 2
  end
  pile
end
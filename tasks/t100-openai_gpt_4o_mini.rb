def make_a_pile(n)
  pile = []
  current = n
  n.times do
    pile << current
    current += (current.odd? ? 2 : 2)
  end
  pile
end
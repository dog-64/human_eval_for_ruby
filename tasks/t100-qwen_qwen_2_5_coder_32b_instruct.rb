def make_a_pile(n)
  pile = []
  current_stones = n
  n.times do
    pile << current_stones
    current_stones += 2
  end
  pile
end
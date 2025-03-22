def make_a_pile(n)
  pile = []
  current_stones = n
  n.times do
    pile << current_stones
    current_stones += (n % 2 == 0) ? 2 : 1
  end
  pile
end

def make_a_pile(n)
  pile = []
  current_stones = n
  n.times do
    pile << current_stones
    if n.odd?
      current_stones += 2
    else
      current_stones += 2
    end
  end
  pile
end
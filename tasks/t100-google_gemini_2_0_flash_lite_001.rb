def make_a_pile(n)
  pile = []
  current_stones = n
  pile << current_stones
  (n - 1).times do
    if current_stones.odd?
      current_stones += 2
    else
      current_stones += 2
    end
    pile << current_stones
  end
  pile
end
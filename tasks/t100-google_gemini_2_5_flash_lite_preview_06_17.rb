def make_a_pile(n)
  pile = []
  current_stones = n
  (n + 1).times do
    pile << current_stones
    if current_stones.odd?
      current_stones += 2
    else
      current_stones += 2
    end
  end
  pile[1..]
end
def make_a_pile(n)
  pile = [n]
  next_stone_count = n + 2 - (n % 2)
  (n - 1).times do
    pile << next_stone_count
    next_stone_count += 2
  end
  pile
end
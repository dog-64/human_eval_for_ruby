def make_a_pile(n)
  pile = []
  current_stones = n
  level = 1

  while level <= n
    if level % 2 != 0
      current_stones += 2
    else
      current_stones += 2
    end
    pile << current_stones
    level += 1
  end

  pile
end

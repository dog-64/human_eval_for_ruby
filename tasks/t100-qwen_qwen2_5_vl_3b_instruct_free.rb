def make_a_pile(n)
  levels = []
  current_level = n
  while current_level > 0
    levels << current_level
    current_level = current_level + 1 if current_level.odd?
    current_level = current_level + 2 if current_level.odd?
  end
  levels
end
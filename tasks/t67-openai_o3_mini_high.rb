def fruit_distribution(fruit_string, total_fruits)
  match = fruit_string.match(/(\d+)\s+apples\s+and\s+(\d+)\s+oranges/)
  if match
    apples = match[1].to_i
    oranges = match[2].to_i
    mangoes = total_fruits - (apples + oranges)
    mangoes > 0 ? mangoes : 0
  else
    0
  end
end
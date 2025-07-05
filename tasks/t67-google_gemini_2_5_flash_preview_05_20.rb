def fruit_distribution(fruit_string, total_fruits)
  parts = fruit_string.split(" ")
  apples = parts[0].to_i
  oranges = parts[3].to_i
  
  other_fruits = apples + oranges
  
  if other_fruits >= total_fruits
    0
  else
    total_fruits - other_fruits
  end
end
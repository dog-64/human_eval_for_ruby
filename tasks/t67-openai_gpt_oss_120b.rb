def fruit_distribution(fruit_string, total_fruits)
  match = fruit_string.match(/(\d+)\s+apples\s+and\s+(\d+)\s+oranges/)
  apples = match[1].to_i
  oranges = match[2].to_i
  mango = total_fruits - (apples + oranges)
  mango < 0 ? 0 : mango
end
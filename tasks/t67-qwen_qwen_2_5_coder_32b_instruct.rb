def fruit_distribution(fruit_string, total_fruits)
  matches = fruit_string.match(/(\d+) apples and (\d+) oranges/)
  apples = matches[1].to_i
  oranges = matches[2].to_i
  total_fruits - (apples + oranges)
end
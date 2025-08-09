def fruit_distribution(fruit_string, total_fruits)
  matches = fruit_string.match(/(\d+)\s+apples\s+and\s+(\d+)\s+oranges/)
  apples = matches[1].to_i
  oranges = matches[2].to_i
  mangoes = total_fruits - apples - oranges
  mangoes < 0 ? 0 : mangoes
end
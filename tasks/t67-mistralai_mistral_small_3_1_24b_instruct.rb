def fruit_distribution(fruit_string, total_fruits)
  apples, oranges = fruit_string.match(/(\d+) apples and (\d+) oranges/).captures.map(&:to_i)
  total_apples_and_oranges = apples + oranges
  total_fruits - total_apples_and_oranges
end
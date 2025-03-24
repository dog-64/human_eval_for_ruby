def fruit_distribution(fruit_string, total_fruits)
  apples_oranges = fruit_string.split(" apples and ").last.split(" oranges").first.to_i
  return total_fruits - apples_oranges
end

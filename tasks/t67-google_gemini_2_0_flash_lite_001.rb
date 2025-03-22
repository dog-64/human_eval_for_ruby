def fruit_distribution(fruit_string, total_fruits)
  apples = fruit_string.split(" apples and ").first.to_i
  oranges = fruit_string.split(" apples and ").last.split(" oranges").first.to_i
  mangoes = total_fruits - apples - oranges
  [mangoes, 0].max
end
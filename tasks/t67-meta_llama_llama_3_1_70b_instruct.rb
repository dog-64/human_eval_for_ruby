def fruit_distribution(fruit_string, total_fruits)
  apples, oranges = fruit_string.scan(/\d+/).map(&:to_i)
  [total_fruits - apples - oranges, 0].max
end
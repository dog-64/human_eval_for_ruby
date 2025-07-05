def fruit_distribution(fruit_string, total_fruits)
  apple_count = fruit_string.match(/(\d+) apples/).captures[0].to_i
  orange_count = fruit_string.match(/(\d+) oranges/).captures[0].to_i
  mango_count = total_fruits - apple_count - orange_count
  [0, mango_count].max
end

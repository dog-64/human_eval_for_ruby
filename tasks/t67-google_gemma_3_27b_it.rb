def fruit_distribution(fruit_string, total_fruits)
  apple_count = fruit_string.split(" ")[0].to_i
  orange_count = fruit_string.split(" ")[-1].to_i
  mango_count = total_fruits - apple_count - orange_count
  mango_count >= 0 ? mango_count : 0
end
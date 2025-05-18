def fruit_distribution(fruit_string, total_fruits)
  apples, oranges = fruit_string.scan(/\d+/).map(&:to_i)
  mangos = total_fruits - (apples + oranges)
  mangos > 0 ? mangos : 0
end
def fruit_distribution(fruit_string, total_fruits)
  apples, oranges = fruit_string.scan(/\d+/).map(&:to_i)
  mangoes = total_fruits - (apples + oranges)
  mangoes < 0 ? 0 : mangoes
end
def fruit_distribution(fruit_string, total_fruits)
  apples, oranges = fruit_string.split(' and ').map(&:to_i)
  mangoes = total_fruits - (apples + oranges)
  mangoes
end
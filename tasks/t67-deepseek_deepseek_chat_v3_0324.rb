def fruit_distribution(fruit_string, total_fruits)
  apples = fruit_string.split(' ')[0].to_i
  oranges = fruit_string.split(' ')[3].to_i
  mangoes = total_fruits - apples - oranges
  mangoes.positive? ? mangoes : 0
end
def fruit_distribution(fruit_string, total_fruits)
  numbers = fruit_string.scan(/\d+/).map(&:to_i)
  apples = numbers[0]
  oranges = numbers[1]
  other_fruits = apples + oranges
  mangoes = total_fruits - other_fruits
  [0, mangoes].max
end
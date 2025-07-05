def fruit_distribution(fruit_string, total_fruits)
  apples_str, oranges_str = fruit_string.split(" and ")
  apples = apples_str.split(" apples")[0].to_i
  oranges = oranges_str.split(" oranges")[0].to_i
  mangoes = total_fruits - apples - oranges
  mangoes
end

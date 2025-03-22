def fruit_distribution(fruit_string, total_fruits)
  apples = fruit_string.scan(/(\d+) apples/).flatten.first.to_i
  oranges = fruit_string.scan(/(\d+) oranges/).flatten.first.to_i
  
  mangoes = total_fruits - apples - oranges
  
  if mangoes < 0
    return 0
  else
    return mangoes
  end
end
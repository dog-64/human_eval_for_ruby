
def fruit_distribution(fruit_string, total_fruits)
  match_data = fruit_string.match(/^(\d+) apples and (\d+) oranges$/)
  apples = match_data[1].to_i
  oranges = match_data[2].to_i
  mangoes = total_fruits - (apples + oranges)
  mangoes < 0 ? 0 : mangoes
end
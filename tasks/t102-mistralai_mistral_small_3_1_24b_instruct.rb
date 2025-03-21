def choose_num(x, y)
  range = (x..y).to_a.reverse
  even_numbers = range.select { |num| num.even? }
  even_numbers.empty? ? -1 : even_numbers.first
end
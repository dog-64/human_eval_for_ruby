def sum_squares(lst)
  lst.map.with_index do |x, i|
    x = x ** 2 if i % 3 == 0
    x = x ** 3 if i % 4 == 0 && i % 3 != 0
    x
  end .sum
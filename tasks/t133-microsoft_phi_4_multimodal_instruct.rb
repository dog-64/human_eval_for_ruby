def sum_squares(lst)
  lst.map { |num| Math.ceil(num) ** 2 }.sum
end
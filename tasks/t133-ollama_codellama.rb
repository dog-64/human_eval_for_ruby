def sum_squares(lst)
  return 0 if lst.empty?
  lst.map { |x| (x.round + 1).to_i ** 2 }.sum
end
def sum_squares(lst)
  return 0 if lst.empty?
  lst.map { |x| (x.to_i**2).to_i }.sum
end
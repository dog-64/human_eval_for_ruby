def sum_squares(lst)
  lst.map { |x| Math.ceil(x).to_i }.map { |x| x * x }.sum
end
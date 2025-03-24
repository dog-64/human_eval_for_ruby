def is_sorted?(lst)
  lst.each_cons(2).all? { |a, b| a <= b }
end
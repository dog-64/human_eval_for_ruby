def sum_squares(lst)
  lst.empty? ? 0 : lst.map { |x| (x.ceil)**2 }.sum
end

def sum_squares(lst)
  lst.reduce(0) do |sum, x|
    r = x.ceil
    r = 0 if r < 0
    sum + r * r
  end
end
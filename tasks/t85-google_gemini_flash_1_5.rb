def add_even_at_odd(lst)
  sum = 0
  lst.each_with_index do |num, index|
    if index.odd? && num.even?
      sum += num
    end
  end
  sum
end

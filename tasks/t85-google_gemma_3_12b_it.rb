def add_even_at_odd(lst)
  sum_of_evens = 0
  lst.each_with_index do |num, index|
    if index.odd? && num.even?
      sum_of_evens += num
    end
  end
  sum_of_evens
end

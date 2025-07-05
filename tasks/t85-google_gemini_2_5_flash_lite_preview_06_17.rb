def add_even_at_odd(lst)
  lst.each_with_index.reduce(0) do |sum, (num, index)|
    if index.odd? && num.even?
      sum + num
    else
      sum
    end
  end
end
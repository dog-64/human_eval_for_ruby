def add_even_at_odd(lst)
  lst.each_with_index.reduce(0) do |sum, (num, index)|
    sum + (index.odd? && num.even? ? num : 0)
  end
end
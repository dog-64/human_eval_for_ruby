def add_even_at_odd(lst)
  lst.each_with_index.inject(0) do |sum, (num, index)|
    index.odd? && num.even? ? sum + num : sum
  end
end
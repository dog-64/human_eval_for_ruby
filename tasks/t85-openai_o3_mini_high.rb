def add_even_at_odd(lst)
  lst.each_with_index.reduce(0) do |sum, (num, idx)|
    idx.odd? && num.even? ? sum + num : sum
  end
end
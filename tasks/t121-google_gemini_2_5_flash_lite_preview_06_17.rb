def sum_odd_even_pos(lst)
  lst.each_with_index.reduce(0) do |sum, (num, index)|
    if index.even? && num.odd?
      sum + num
    else
      sum
    end
  end
end

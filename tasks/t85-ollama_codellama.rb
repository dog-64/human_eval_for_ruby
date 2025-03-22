def add_even_at_odd(lst)
  sum = 0
  lst.each_with_index do |num, index|
    if index % 2 == 1 && num % 2 == 0
      sum += num
    end
  end
  return sum
end
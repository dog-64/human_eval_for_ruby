def even_odd_count(num)
  count_even = 0
  count_odd = 0
  num.abs.to_s.each_char do |char|
    digit = char.to_i
    if digit % 2 == 0
      count_even += 1
    else
      count_odd += 1
    end
  end
  [count_even, count_odd]
end

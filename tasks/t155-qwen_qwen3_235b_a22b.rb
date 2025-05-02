def even_odd_count(num)
  even = 0
  odd = 0
  num_abs = num.abs
  num_abs.to_s.each_char do |c|
    digit = c.to_i
    if digit.even?
      even += 1
    else
      odd += 1
    end
  end
  [even, odd]
end
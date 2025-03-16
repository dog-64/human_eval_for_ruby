def even_odd_count(num)
  n = num.abs
  return [1, 0] if n == 0
  even = 0
  odd = 0
  n.to_s.each_char do |char|
    digit = char.to_i
    if digit % 2 == 0
      even += 1
    else
      odd += 1
    end
  end
  [even, odd]
end
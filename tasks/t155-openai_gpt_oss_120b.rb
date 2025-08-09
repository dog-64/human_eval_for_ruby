def even_odd_count(num)
  return [1, 0] if num == 0
  even = 0
  odd = 0
  num.abs.to_s.each_char do |ch|
    digit = ch.ord - 48
    if digit.even?
      even += 1
    else
      odd += 1
    end
  end
  [even, odd]
end
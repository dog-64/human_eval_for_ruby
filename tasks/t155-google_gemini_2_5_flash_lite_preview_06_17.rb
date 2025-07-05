def even_odd_count(num)
  even_count = 0
  odd_count = 0
  num = num.abs.to_s
  num.each_char do |char|
    digit = char.to_i
    if digit.even?
      even_count += 1
    else
      odd_count += 1
    end
  end
  [even_count, odd_count]
end
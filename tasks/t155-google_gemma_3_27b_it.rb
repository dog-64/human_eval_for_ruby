
def even_odd_count(num)
  even_count = 0
  odd_count = 0
  num_str = num.abs.to_s
  num_str.each_char do |digit|
    digit_int = digit.to_i
    if digit_int % 2 == 0
      even_count += 1
    else
      odd_count += 1
    end
  end
  if num == 0
    return [1, 0]
  else
    return [even_count, odd_count]
  end
end

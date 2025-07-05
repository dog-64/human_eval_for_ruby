def even_odd_count(num)
  num_str = num.to_s
  even_count = 0
  odd_count = 0
  
  if num == 0
    return [1, 0]
  end

  num_str.each_char do |digit|
    digit = digit.to_i
    if digit % 2 == 0
      even_count += 1
    else
      odd_count += 1
    end
  end
  
  [even_count, odd_count]
end

def even_odd_count(num)
  num = num.abs
  even_count = 0
  odd_count = 0
  num.to_s.each_char do |digit|
    digit = digit.to_i
    if digit == 0
      even_count += 1
    elsif digit % 2 == 0
      even_count += 1
    else
      odd_count += 1
    end
  end
  return [even_count, odd_count]
end

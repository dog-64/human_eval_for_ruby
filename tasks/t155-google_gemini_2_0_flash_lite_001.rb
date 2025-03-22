def even_odd_count(num)
  num_str = num.abs.to_s
  even_count = 0
  odd_count = 0

  if num_str == "0"
    return [1, 0]
  end

  num_str.each_char do |digit|
    digit_int = digit.to_i
    if digit_int.even?
      even_count += 1
    else
      odd_count += 1
    end
  end

  [even_count, odd_count]
end
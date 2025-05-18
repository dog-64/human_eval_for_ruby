def even_odd_count(num)
  num = num.abs
  even_count = 0
  odd_count = 0

  if num == 0
    return [1, 0]
  end

  num.to_s.each_char do |digit|
    digit = digit.to_i
    if digit.even?
      even_count += 1
    else
      odd_count += 1
    end
  end

  [even_count, odd_count]
end
def even_odd_count(num)
  abs_num = num.abs
  return [1, 0] if abs_num == 0
  even_count = 0
  odd_count = 0
  abs_num.to_s.each_char do |ch|
    digit = ch.to_i
    if digit.even?
      even_count += 1
    else
      odd_count += 1
    end
  end
  [even_count, odd_count]
end
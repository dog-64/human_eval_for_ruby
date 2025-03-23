def count_nums(arr)
  count = 0
  arr.each do |num|
    sum = 0
    num_str = num.to_s
    if num_str[0] == '-'
      sum -= 1
      num_str[1..-1].each_char do |digit|
        sum += digit.to_i
      end
    else
      num_str.each_char do |digit|
        sum += digit.to_i
      end
    end
    count += 1 if sum > 0
  end
  count
end
def count_nums(arr)
  arr.count do |num|
    sum = 0
    num_str = num.to_s
    if num_str[0] == '-'
      sum += -(num_str[1].to_i)
      num_str[2..-1].each_char { |digit| sum += digit.to_i }
    else
      num_str.each_char { |digit| sum += digit.to_i }
    end
    sum > 0
  end
end
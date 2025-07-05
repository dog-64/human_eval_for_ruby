def count_nums(arr)
  arr.count do |num|
    sum = 0
    s_num = num.to_s
    if s_num[0] == '-'
      sum -= s_num[1].to_i
      s_num[2..-1].each_char { |c| sum += c.to_i } unless s_num.length < 3
    else
      s_num.each_char { |c| sum += c.to_i }
    end
    sum > 0
  end
end
def count_nums(arr)
  arr.count do |num|
    sum = 0
    s = num.to_s
    if s[0] == '-'
      sum -= s[1].to_i
      s[2..-1].each_char { |c| sum += c.to_i } unless s.length < 3
    else
      s.each_char { |c| sum += c.to_i }
    end
    sum > 0
  end
end
def count_nums(arr)
  count = 0
  arr.each do |num|
    sum = 0
    num_str = num.to_s
    if num < 0
      sum += num_str[0].to_i
      (1...num_str.length).each do |i|
        sum += num_str[i].to_i
      end
    else
      num_str.each_char do |char|
        sum += char.to_i
      end
    end
    if sum > 0
      count += 1
    end
  end
  count
end
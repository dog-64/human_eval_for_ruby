def count_nums(arr)
  count = 0
  arr.each do |num|
    sum = 0
    num.to_s.each_char do |char|
      digit = char.to_i
      if digit < 0
        sum += digit
      else
        sum += digit
      end
    end
    if sum > 0
      count += 1
    end
  end
  count
end

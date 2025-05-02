def double_the_difference(numbers)
  sum = 0
  numbers.each do |num|
    next unless num.positive?
    next unless num == num.to_i
    int_num = num.to_i
    next unless int_num.odd?
    sum += int_num ** 2
  end
  sum
end
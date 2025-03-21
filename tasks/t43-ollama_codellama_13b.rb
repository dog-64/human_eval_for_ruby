def pairs_sum_to_zero(numbers)
  return false if numbers.empty?

  numbers.each do |num|
    other_num = numbers - [num]
    if other_num.any? { |n| n + num == 0 }
      return true
    end
  end

  false
end
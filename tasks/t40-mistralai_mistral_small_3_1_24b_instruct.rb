def triples_sum_to_zero(numbers)
  return false if numbers.length < 3

  numbers.sort!
  numbers.each_with_index do |num, i|
    left, right = i + 1, numbers.length - 1
    while left < right
      sum = num + numbers[left] + numbers[right]
      return true if sum == 0
      if sum < 0
        left += 1
      else
        right -= 1
      end
    end
  end
  false
end
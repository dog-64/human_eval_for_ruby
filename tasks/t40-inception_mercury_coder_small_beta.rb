def triples_sum_to_zero(numbers)
  return false if numbers.length < 3
  numbers.sort!
  (0...numbers.length - 2).each do |i|
    left, right = i + 1, numbers.length - 1
    while left < right
      sum = numbers[i] + numbers[left] + numbers[right]
      return true if sum == 0
      left += 1 if sum < 0
      right -= 1 if sum > 0
    end
  end
  false
end
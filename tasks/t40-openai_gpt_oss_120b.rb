def triples_sum_to_zero(numbers)
  n = numbers.length
  return false if n < 3
  nums = numbers.sort
  (0...n - 2).each do |i|
    left = i + 1
    right = n - 1
    while left < right
      sum = nums[i] + nums[left] + nums[right]
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
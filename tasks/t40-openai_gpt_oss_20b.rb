def triples_sum_to_zero(numbers)
  return false if numbers.length < 3
  arr = numbers.sort
  n = arr.length
  (0...n-2).each do |i|
    left = i + 1
    right = n - 1
    while left < right
      sum = arr[i] + arr[left] + arr[right]
      if sum == 0
        return true
      elsif sum < 0
        left += 1
      else
        right -= 1
      end
    end
  end
  false
end
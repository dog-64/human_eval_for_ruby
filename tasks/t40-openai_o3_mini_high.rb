def triples_sum_to_zero(numbers)
  return false if numbers.size < 3
  sorted = numbers.sort
  n = sorted.size
  (0...n - 2).each do |i|
    left = i + 1
    right = n - 1
    while left < right
      sum = sorted[i] + sorted[left] + sorted[right]
      return true if sum.zero?
      if sum < 0
        left += 1
      else
        right -= 1
      end
    end
  end
  false
end
def triples_sum_to_zero(numbers)
  return false if numbers.length < 3
  numbers.combination(3).any? { |a, b, c| a + b + c == 0 }
end


def triples_sum_to_zero(numbers)
  numbers = numbers.sort
  (0...numbers.length).each do |i|
    left = i + 1
    right = numbers.length - 1
    while left < right
      sum = numbers[i] + numbers[left] + numbers[right]
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
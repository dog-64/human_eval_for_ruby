def triples_sum_to_zero(numbers)
  return false if numbers.length < 3

  numbers.sort!
  n = numbers.length

  0.upto(n - 3) do |i|
    left = i + 1
    right = n - 1

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
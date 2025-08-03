
def triples_sum_to_zero(numbers)
  n = numbers.length
  return false if n < 3

  numbers.sort!

  for i in 0..n-3
    next if i > 0 && numbers[i] == numbers[i-1]

    left = i + 1
    right = n - 1

    while left < right
      total = numbers[i] + numbers[left] + numbers[right]
      if total == 0
        return true
      elsif total < 0
        left += 1
      else
        right -= 1
      end
    end
  end

  false
end
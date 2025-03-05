def triples_sum_to_zero(numbers)
  n = numbers.length
  return false if n < 3

  (0..(n - 3)).each do |i|
    ((i + 1)..(n - 2)).each do |j|
      ((j + 1)..(n - 1)).each do |k|
        if numbers[i] + numbers[j] + numbers[k] == 0
          return true
        end
      end
    end
  end

  return false
end
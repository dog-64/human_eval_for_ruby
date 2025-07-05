def triples_sum_to_zero(numbers)
  return false if numbers.length < 3

  numbers.each_with_index do |num1, i|
    numbers.each_with_index do |num2, j|
      next if i == j
      numbers.each_with_index do |num3, k|
        next if i == k || j == k
        return true if num1 + num2 + num3 == 0
      end
    end
  end
  false
end
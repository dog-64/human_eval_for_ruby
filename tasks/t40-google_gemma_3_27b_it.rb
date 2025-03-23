
def triples_sum_to_zero(numbers)
  n = numbers.length
  return false if n < 3

  numbers.each_with_index do |num1, i|
    (i + 1).upto(n - 1) do |j|
      (j + 1).upto(n - 1) do |k|
        if num1 + numbers[j] + numbers[k] == 0
          return true
        end
      end
    end
  end

  false
end

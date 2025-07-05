def triples_sum_to_zero(numbers)
  numbers.each do |num1|
    numbers.each do |num2|
      numbers.each do |num3|
        if num1 != num2 && num1 != num3 && num2 != num3 && num1 + num2 + num3 == 0
          return true
        end
      end
    end
  end
  false
end

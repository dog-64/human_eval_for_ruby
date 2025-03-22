def unique_digits(numbers)
  result = []
  numbers.each do |number|
    digits = number.to_s.chars.map(&:to_i)
    is_unique = true
    digits.each do |digit|
      if digit % 2 == 0
        is_unique = false
        break
      end
    end
    if is_unique
      result << number
    end
  end
  result.sort
end
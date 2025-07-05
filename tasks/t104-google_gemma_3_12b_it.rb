def unique_digits(numbers)
  result = []
  numbers.each do |number|
    if is_unique_digits?(number)
      result << number
    end
  end
  result.sort
end

def is_unique_digits?(number)
  number.to_s.each_char do |digit|
    if digit.to_i % 2 == 0
      return false
    end
  end
  true
end

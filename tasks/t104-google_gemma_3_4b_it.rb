def unique_digits(numbers)
  result = []
  numbers.each do |number|
    is_valid = true
    number_str = number.to_s
    number_str.each_char do |digit_char|
      digit = digit_char.to_i
      if digit % 2 == 0
        is_valid = false
        break
      end
    end
    if is_valid
      result << number
    end
  end
  result.sort
end

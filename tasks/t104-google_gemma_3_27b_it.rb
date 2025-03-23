
def unique_digits(numbers)
  result = []
  numbers.each do |number|
    str_number = number.to_s
    has_even_digit = false
    str_number.each_char do |digit|
      if digit.to_i % 2 == 0
        has_even_digit = true
        break
      end
    end
    result << number unless has_even_digit
  end
  result.sort
end

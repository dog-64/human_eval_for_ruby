def int_to_mini_roman(number)
  return 'I' if number == 1
  return 'X' if number == 10
  return 'C' if number == 100
  return 'M' if number == 1000

  roman_numerals = {
    1000 => 'M', 
    900 => 'CM', 
    500 => 'D', 
    400 => 'CD', 
    100 => 'C', 
    90 => 'XC', 
    50 => 'L', 
    40 => 'XL', 
    10 => 'X', 
    9 => 'IX', 
    5 => 'V', 
    4 => 'IV', 
    1 => 'I'
  }

  result = ''
  roman_numerals.each do |value, letter|
    while number >= value
      result += letter
      number -= value
    end
  end

  result
end
def int_to_mini_roman(number)
  raise ArgumentError, "Number must be between 1 and 1000" unless 1 <= number <= 1000
  roman_map = { 1 => 'i', 4 => 'iv', 5 => 'v', 9 => 'ix', 10 => 'x', 40 => 'xl', 50 => 'l', 90 => 'xc', 100 => 'c', 400 => 'cd', 500 => 'd', 900 => 'cm', 1000 => 'm' }
  result = ''
  roman_map.each do |value, symbol|
    while number >= value
      result += symbol
      number -= value
    end
  end
  result
end

def int_to_mini_roman(number)
  raise ArgumentError, "Number must be a positive integer between 1 and 1000" unless (1..1000).cover?(number)

  roman_map = {
    1000 => 'm',
    900 => 'cm',
    500 => 'd',
    400 => 'cd',
    100 => 'c',
    90 => 'xc',
    50 => 'l',
    40 => 'xl',
    10 => 'x',
    9 => 'ix',
    5 => 'v',
    4 => 'iv',
    1 => 'i'
  }

  result = ""
  roman_map.each do |value, symbol|
    while number >= value
      result += symbol
      number -= value
    end
  end
  result
end

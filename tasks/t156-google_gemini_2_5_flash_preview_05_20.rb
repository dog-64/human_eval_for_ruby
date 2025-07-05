def int_to_mini_roman(number)
  roman_map = {
    1000 => "m",
    900 => "cm",
    500 => "d",
    400 => "cd",
    100 => "c",
    90 => "xc",
    50 => "l",
    40 => "xl",
    10 => "x",
    9 => "ix",
    5 => "v",
    4 => "iv",
    1 => "i"
  }

  result = ""
  roman_map.keys.sort.reverse_each do |value|
    while number >= value
      result += roman_map[value]
      number -= value
    end
  end
  result
end
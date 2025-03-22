def int_to_mini_roman(number)
  roman_numerals = [
    ['m', 1000], ['cm', 900], ['d', 500], ['cd', 400],
    ['c', 100], ['xc', 90], ['l', 50], ['xl', 40],
    ['x', 10], ['ix', 9], ['v', 5], ['iv', 4], ['i', 1]
  ]

  result = ''
  roman_numerals.each do |roman, value|
    while number >= value
      result += roman
      number -= value
    end
  end
  result
end
def int_to_mini_roman(number)
  roman_mapping = [
    [1000, "m"],
    [900, "cm"],
    [500, "d"],
    [400, "cd"],
    [100, "c"],
    [90, "xc"],
    [50, "l"],
    [40, "xl"],
    [10, "x"],
    [9, "ix"],
    [5, "v"],
    [4, "iv"],
    [1, "i"]
  ]

  raise ArgumentError, "number must be an integer between 1 and 1000" unless number.is_a?(Integer) && number.between?(1, 1000)

  result = ""

  roman_mapping.each do |value, numeral|
    while number >= value
      result << numeral
      number -= value
    end
  end

  result
end
def int_to_mini_roman(number)
  values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
  numerals = %w[m cm d cd c xc l xl x ix v iv i]
  
  result = ''
  values.each_with_index do |value, index|
    count = number / value
    if count > 0
      result << numerals[index] * count
      number -= value * count
    end
  end
  
  result
end
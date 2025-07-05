def get_positive(numbers)
  positive_numbers = []
  numbers.each do |number|
    if number > 0
      positive_numbers << number
    end
  end
  positive_numbers
end

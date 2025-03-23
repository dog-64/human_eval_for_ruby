
def get_positive(numbers)
  positive_numbers = []
  numbers.each do |number|
    positive_numbers << number if number > 0
  end
  positive_numbers
end

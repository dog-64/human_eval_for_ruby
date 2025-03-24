def remove_duplicates(numbers)
  numbers.each_with_object([]) do |number, unique_numbers|
    unique_numbers << number unless unique_numbers.include?(number)
  end
end
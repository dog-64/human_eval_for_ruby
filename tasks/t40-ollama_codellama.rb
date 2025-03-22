def triples_sum_to_zero(numbers)
  # check if the list is empty
  return false if numbers.empty?

  # create a set of unique elements in the list
  unique_elements = Set.new(numbers)

  # loop through each element in the set and check if there are any other two elements that sum to zero
  unique_elements.each do |element|
    other_elements = unique_elements - [element]
    if other_elements.any? { |other_element| element + other_element == 0 }
      return true
    end
  end

  # if no triples were found, return false
  return false
end
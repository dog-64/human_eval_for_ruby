def search(lst)
  frequency = lst.group_by(&:it).transform_values(&:size)
  valid_numbers = frequency.select { |num, count| count >= num }.keys
  valid_numbers.empty? ? -1 : valid_numbers.max
end
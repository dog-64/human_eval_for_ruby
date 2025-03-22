def search(lst)
  frequency = lst.each_with_object(Hash.new(0)) { |num, hash| hash[num] += 1 }
  valid_numbers = frequency.select { |num, count| count >= num }.keys
  valid_numbers.empty? ? -1 : valid_numbers.max
end
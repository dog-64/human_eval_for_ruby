def search(lst)
  freq = lst.each_with_object(Hash.new(0)) { |num, h| h[num] += 1 }
  valid_numbers = freq.select { |num, count| count >= num }.keys
  valid_numbers.empty? ? -1 : valid_numbers.max
end

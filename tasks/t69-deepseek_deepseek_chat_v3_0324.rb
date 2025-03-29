def search(lst)
  frequency = lst.each_with_object(Hash.new(0)) { |num, h| h[num] += 1 }
  candidates = frequency.select { |num, count| count >= num }.keys
  candidates.empty? ? -1 : candidates.max
end
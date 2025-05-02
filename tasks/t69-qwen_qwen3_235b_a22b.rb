def search(lst)
  freq = lst.each_with_object(Hash.new(0)) { |num, hash| hash[num] += 1 }
  candidates = freq.select { |num, count| count >= num }.keys
  candidates.max || -1
end
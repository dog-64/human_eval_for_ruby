def search(lst)
  freq = Hash.new(0)
  lst.each { |num| freq[num] += 1 }
  candidates = freq.select { |num, count| count >= num }.keys
  candidates.empty? ? -1 : candidates.max
end
def search(lst)
  counts = Hash.new(0)
  lst.each { |n| counts[n] += 1 }
  candidate = counts.select { |num, freq| freq >= num }.keys.max
  candidate.nil? ? -1 : candidate
end
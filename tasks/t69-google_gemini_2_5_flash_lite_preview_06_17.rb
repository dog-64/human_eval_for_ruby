def search(lst)
  counts = lst.tally
  candidates = counts.select { |num, count| count >= num }
  candidates.empty? ? -1 : candidates.keys.max
end

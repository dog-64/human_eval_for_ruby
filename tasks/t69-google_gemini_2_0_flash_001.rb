def search(lst)
  counts = Hash.new(0)
  lst.each { |x| counts[x] += 1 }

  eligible = counts.select { |num, count| count >= num && num > 0 }.keys
  
  if eligible.empty?
    return -1
  else
    return eligible.max
  end
end
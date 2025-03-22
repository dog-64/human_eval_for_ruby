def search(lst)
  frequency = Hash.new(0)
  lst.each { |num| frequency[num] += 1 }

  frequency.keys.max_by { |num| num if num <= frequency[num] } || -1
end
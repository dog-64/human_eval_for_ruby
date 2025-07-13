def search(lst)
  frequency = Hash.new(0)
  lst.each { |num| frequency[num] += 1 }
  
  result = -1
  frequency.each do |num, count|
    result = num if count >= num && num > result
  end
  
  result
end
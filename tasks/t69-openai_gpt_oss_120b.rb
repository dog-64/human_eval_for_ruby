def search(lst)
  freq = Hash.new(0)
  lst.each { |x| freq[x] += 1 }
  result = -1
  freq.each do |num, count|
    if count >= num && num > result
      result = num
    end
  end
  result
end
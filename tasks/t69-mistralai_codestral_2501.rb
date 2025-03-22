def search(lst)
  freq = Hash.new(0)
  lst.each { |num| freq[num] += 1 }
  max_num = -1
  freq.each do |num, count|
    if count >= num && num > max_num
      max_num = num
    end
  end
  max_num
end
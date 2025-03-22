def search(lst)
  counter = Hash.new(0)
  lst.each { |num| counter[num] += 1 }
  max_num = -1
  counter.each do |num, count|
    max_num = num if num <= count && num > max_num
  end
  max_num
end
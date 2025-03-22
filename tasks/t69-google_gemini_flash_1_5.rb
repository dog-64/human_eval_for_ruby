def search(lst)
  counts = Hash.new(0)
  lst.each { |x| counts[x] += 1 }
  max_num = -1
  counts.each do |num, count|
    if count >= num && num > max_num
      max_num = num
    end
  end
  max_num
end

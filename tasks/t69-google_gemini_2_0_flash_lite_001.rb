def search(lst)
  counts = Hash.new(0)
  lst.each { |x| counts[x] += 1 }
  result = -1
  counts.each do |num, count|
    if num <= count && num > result
      result = num
    end
  end
  result
end
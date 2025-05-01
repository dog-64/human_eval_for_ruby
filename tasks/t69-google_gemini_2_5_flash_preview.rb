def search(lst)
  counts = lst.each_with_object(Hash.new(0)) { |num, hash| hash[num] += 1 }
  result = -1
  counts.each do |num, count|
    if num > 0 && count >= num
      result = [result, num].max
    end
  end
  result
end
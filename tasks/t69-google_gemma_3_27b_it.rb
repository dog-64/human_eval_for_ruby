def search(lst)
  counts = {}
  lst.each do |num|
    counts[num] = counts.fetch(num, 0) + 1
  end

  result = -1
  counts.each do |num, count|
    if count >= num && num > result
      result = num
    end
  end

  return result
end
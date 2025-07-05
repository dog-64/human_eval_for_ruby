def search(lst)
  counts = {}
  lst.each do |num|
    counts[num] = counts.key(num) ? counts[num] + 1 : 1
  end

  var = -1
  counts.each do |num, count|
    if count >= num && num > var
      var = num
    end
  end

  var
end

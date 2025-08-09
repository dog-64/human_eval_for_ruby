def is_sorted?(lst)
  prev = nil
  count = 0
  lst.each do |num|
    return false if prev && num < prev
    if prev == num
      count += 1
      return false if count > 2
    else
      count = 1
    end
    prev = num
  end
  true
end
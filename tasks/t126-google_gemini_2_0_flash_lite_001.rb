def is_sorted?(lst)
  return true if lst.empty?

  seen = {}
  prev = lst[0]

  lst.each_with_index do |num, index|
    if index > 0
      return false if num < prev
      return false if seen[num]
      prev = num
    end
    seen[num] = true
  end

  true
end
def is_sorted?(lst)
  return true if lst.empty?

  seen = {}
  lst.each_with_index do |num, index|
    return false if num < 0
    return false if index > 0 && num < lst[index - 1]

    if seen[num]
      return false if seen[num] >= 1
      seen[num] += 1
    else
      seen[num] = 1
    end
  end

  true
end

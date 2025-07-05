def is_sorted?(lst)
  return true if lst.empty?

  seen = Set.new
  lst.each_with_index do |num, i|
    return false if seen.include?(num)
    seen.add(num)

    if i > 0 && lst[i - 1] > num
      return false
    end
  end

  true
end
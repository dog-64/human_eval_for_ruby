def is_sorted?(lst)
  if lst.empty?
    return true
  end

  seen = {}
  lst.each do |num|
    if seen[num]
      return false
    end
    seen[num] = true
  end

  sorted = true
  lst.each_cons(2) do |pair|
    if pair[0] > pair[1]
      sorted = false
      break
    end
  end

  sorted
end

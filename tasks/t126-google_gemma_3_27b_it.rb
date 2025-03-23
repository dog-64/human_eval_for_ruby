def is_sorted?(lst)
  return true if lst.empty?

  seen = {}
  for i in 0...lst.length
    if seen.key?(lst[i])
      return false
    end
    seen[lst[i]] = true

    if i > 0 && lst[i] < lst[i - 1]
      return false
    end
  end

  return true
end
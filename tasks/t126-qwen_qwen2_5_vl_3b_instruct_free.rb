def is_sorted?(lst)
  return true if lst.empty?

  lst.each_with_index do |num, idx|
    return false if lst[idx + 1] && lst[idx] >= lst[idx + 1]
  end

  true
end

def strange_sort_list(lst)
  return [] if lst.empty?

  result = []
  nums = lst.clone
  min_max = true

  while !nums.empty?
    if min_max
      min_val = nums.min
      result << min_val
      nums.delete(min_val)
    else
      max_val = nums.max
      result << max_val
      nums.delete(max_val)
    end
    min_max = !min_max
  end

  return result
end

def strange_sort_list(lst)
  sorted = lst.sort
  result = []
  left = 0
  right = sorted.length - 1
  take_min = true
  while left <= right
    if take_min
      result << sorted[left]
      left += 1
    else
      result << sorted[right]
      right -= 1
    end
    take_min = !take_min
  end
  result
end
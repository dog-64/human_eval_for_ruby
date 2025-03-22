def strange_sort_list(lst)
  return [] if lst.empty?

  sorted_lst = []
  lst = lst.sort
  left = 0
  right = lst.length - 1

  while left <= right
    sorted_lst << lst[left]
    left += 1
    break if left > right
    sorted_lst << lst[right]
    right -= 1
  end

  return sorted_lst
end
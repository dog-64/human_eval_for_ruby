
def strange_sort_list(lst)
  sorted = lst.sort
  result = []
  left = 0
  right = sorted.length - 1
  while left <= right
    if result.size.even?
      result << sorted[left]
      left += 1
    else
      result << sorted[right]
      right -= 1
    end
  end
  result
end
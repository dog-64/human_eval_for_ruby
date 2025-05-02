def strange_sort_list(lst)
  sorted = lst.sort
  result = []
  left = 0
  right = sorted.length - 1
  direction = :min

  while left <= right
    if direction == :min
      result << sorted[left]
      left += 1
    else
      result << sorted[right]
      right -= 1
    end
    direction = direction == :min ? :max : :min
  end

  result
end
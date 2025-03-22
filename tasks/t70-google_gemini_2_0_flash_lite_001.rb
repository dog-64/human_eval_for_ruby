def strange_sort_list(lst)
  return [] if lst.empty?

  sorted_lst = []
  left = 0
  right = lst.length - 1

  while left <= right
    min_index = left
    max_index = left

    (left..right).each do |i|
      if lst[i] < lst[min_index]
        min_index = i
      end
      if lst[i] > lst[max_index]
        max_index = i
      end
    end

    if min_index == max_index
      sorted_lst << lst[min_index]
      left += 1
      right -= 1
    else
      sorted_lst << lst[min_index]
      sorted_lst << lst[max_index]
       
      lst[min_index], lst[left] = lst[left], lst[min_index]
      lst[max_index], lst[right] = lst[right], lst[max_index]
      
      left += 1
      right -= 1
      
      if left == right
        
      end
    end
  end

  return sorted_lst
end
def can_arrange(arr)
  arr.each_with_index do |_, i| i == arr.length - 1 || arr[i] > arr[i + 1] ? -1 : i
end

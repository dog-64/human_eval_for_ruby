def can_arrange(arr)
  arr.each_with_index { |x, i| break i if i < arr[i.pred] }
end
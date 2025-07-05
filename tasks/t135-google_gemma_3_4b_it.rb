def can_arrange(arr)
  result = -1
  arr.each_with_index do |element, index|
    if index > 0 && element < arr[index - 1]
      result = index
    end
  end
  result
end


def can_arrange(arr)
  arr.each_with_index do |element, i|
    return i if i > 0 && element < arr[i-1]
  end
  -1
end

 
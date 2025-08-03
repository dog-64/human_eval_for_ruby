
def can_arrange(arr)
  return -1 if arr.empty? || arr.length == 1

  (1...arr.length).each do |i|
    if arr[i] < arr[i-1]
      return i
    end
  end

  -1
end
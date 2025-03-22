def can_arrange(arr)
  return -1 if arr.nil? || arr.empty?

  (1...arr.length).each do |i|
    if arr[i] < arr[i - 1]
      return i
    end
  end

  return -1
end
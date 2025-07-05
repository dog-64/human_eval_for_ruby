def add_elements(arr, k)
  sum = 0
  (0...k).each do |i|
    if arr[i].to_s.length <= 2
      sum += arr[i]
    end
  end
  sum
end

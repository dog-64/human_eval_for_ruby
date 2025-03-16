def add_elements(arr, k)
  sum = 0
  arr[0...k].each do |num|
    if num.to_s.size <= 2
      sum += num
    end
  end
  sum
end
def add_elements(arr, k)
  sum = 0
  for i in 0...k
    num = arr[i]
    if num.to_s.length <= 2
      sum += num
    end
  end
  sum
end

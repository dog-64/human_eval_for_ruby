def add_elements(arr, k)
  sum = 0
  arr.each_with_index do |num, index|
    return sum if index >= k
    sum += num if num.abs < 100
  end
  sum
end
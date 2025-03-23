
def add_elements(arr, k)
  sum = 0
  for i in 0...k
    num = arr[i]
    if num.abs <= 99
      sum += num
    end
  end
  return sum
end

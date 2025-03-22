def add_elements(arr, k)
  arr.take(k).select { |x| x.abs < 100 }.sum
end
def add_elements(arr, k)
  arr.first(k).select { |num| num.abs < 100 }.sum
end
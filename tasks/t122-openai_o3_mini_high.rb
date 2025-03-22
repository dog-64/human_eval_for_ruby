def add_elements(arr, k)
  arr.first(k).select { |n| n.abs.to_s.size <= 2 }.sum
end
def add_elements(arr, k)
  arr.first(k).select { |num| num.abs.to_s.length <= 2 }.sum
end
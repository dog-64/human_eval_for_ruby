def add_elements(arr, k)
  sum = 0
  arr.first(k).each do |x|
    sum += x if x.abs.to_s.length <= 2
  end
  sum
end
def add_elements(arr, k)
  sum = 0
  arr.first(k).each do |num|
    sum += num if num.abs <= 99
  end
  sum
end